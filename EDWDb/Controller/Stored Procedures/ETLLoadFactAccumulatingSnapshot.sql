
CREATE PROCEDURE [Controller].[ETLLoadFactAccumulatingSnapshot](
	@FactTableName nvarchar(128),
	@DebugOnly bit = 0
)
AS
BEGIN

DECLARE @TempTableName NVARCHAR(128) = 'Transform.' + @FactTableName + 'Temp';
DECLARE @DropTempTable NVARCHAR(128);
DECLARE @CreateTempTable NVARCHAR(128);
DECLARE @UpdateAuditTable NVARCHAR(500);
DECLARE @InsertAuditTable NVARCHAR(500);

	DECLARE @ExecutionId BIGINT;
	SELECT @ExecutionId = ISNULL(MAX([execution_id]), - 1) FROM [SSISDB].[catalog].[executions] WHERE package_name = 'Controller.dtsx'	AND STATUS = 2;

	SET @DropTempTable = 'DROP TABLE ' + @TempTableName

	SET @CreateTempTable = 'CREATE TABLE '  + @TempTableName + '(		ChangeType NVARCHAR(10)
		,ExecutionID BIGINT NOT NULL
		);'

	IF OBJECT_ID(@TempTableName) IS NOT NULL
	EXEC (@DropTempTable);

	EXEC (@CreateTempTable);

	IF (@DebugOnly = 1)
		PRINT N'@FactTableName: ' + ISNULL(@FactTableName,N'NULL');

	DECLARE @FQTargetTableName nvarchar(256) = N'[Model].[' + @FactTableName + N']';
	DECLARE @FQTempTableName nvarchar(256) = N'[Transform].[' + @FactTableName + N'Changes]';
	DECLARE @FQChangedKeysTableName nvarchar(256) = N'[Transform].[' + @FactTableName + N'ChangedKeys]';

	DECLARE @MergeStatement nvarchar(max) = N'
MERGE ' + @FQTargetTableName + N' AS target USING (
SELECT
	#ColumnName#
FROM ' + @FQTempTableName + N') AS source (
	#ColumnName#
)
	#PrimaryKeyJoin#
WHEN MATCHED AND
(
    #ColumnValuePredicates#
)
THEN UPDATE SET
	#ColumnValueSet#
WHEN NOT MATCHED THEN INSERT (
	#ColumnName#
) VALUES (
	#ColumnValue#)
	OUTPUT
       $ACTION ChangeType,
       inserted.ExecutionID
    INTO ' + @TempTableName + ';';

	DECLARE C_COLUMN_LIST CURSOR FOR (
		SELECT
			[ColumnOrdinal], [ColumnName], [IsPrimaryKey], [PrimaryKeyIndex]
		FROM [Controller].[fnModelColumns](@FactTableName)
	)--note: the order of the columns is critical for token replacement
	ORDER BY [ColumnOrdinal] DESC;

	OPEN C_COLUMN_LIST;
	DECLARE @ColumnOrdinal int, @ColumnName sysname, @IsPrimaryKey bit, @PrimaryKeyIndex int;
	FETCH NEXT FROM C_COLUMN_LIST INTO @ColumnOrdinal, @ColumnName, @IsPrimaryKey, @PrimaryKeyIndex;
	WHILE(@@FETCH_STATUS = 0)
		BEGIN
			DECLARE @ReinsertToken bit = (CASE WHEN (@ColumnOrdinal > 1) THEN 1 ELSE 0 END);
			DECLARE @AppendToList bit = (CASE WHEN (@ColumnOrdinal > 1) THEN 1 ELSE 0 END);

			EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
				@DMLStatement = @MergeStatement OUTPUT,
				@Token = N'#ColumnName#',
				@ColumnName = @ColumnName,
				@ReinsertToken = @ReinsertToken,
				@AppendToList = @AppendToList;

			EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
				@DMLStatement = @MergeStatement OUTPUT,
				@Token = N'#ColumnValue#',
				@TableAlias = N'source',
				@ColumnName = @ColumnName,
				@ReinsertToken = @ReinsertToken,
				@AppendToList = @AppendToList;

			IF(@IsPrimaryKey = 1)
				BEGIN
					DECLARE @ReinsertPKToken bit = (CASE WHEN (@PrimaryKeyIndex > 1) THEN 1 ELSE 0 END);

					EXEC [Controller].[ETLReplaceTokenJoinCondition]
						@DMLStatement = @MergeStatement OUTPUT,
						@Token = N'#PrimaryKeyJoin#',
						@ColumnName = @ColumnName,
						@TableAlias = N'target',
						@ReferencedColumnName = @ColumnName,
						@ReferencedTableAlias = N'source',
						@ReinsertToken = @ReinsertPKToken;
				END
			ELSE
				BEGIN
					EXEC [Controller].[ETLReplaceTokenForColumnUpdatePredicates]
						@DMLStatement = @MergeStatement OUTPUT,
						@Token = N' #ColumnValuePredicates#',
						@TargetColumnName = @ColumnName,
						@SourceTableAlias = N'source',
						@SourceColumnName = @ColumnName,
						@ReinsertToken = @ReinsertToken,
						@AppendToList = @AppendToList,
						@TargetTableName = @FQTargetTableName;

					EXEC [Controller].[ETLReplaceTokenForColumnUpdate]
						@DMLStatement = @MergeStatement OUTPUT,
						@Token = N'#ColumnValueSet#',
						@TargetColumnName = @ColumnName,
						@SourceTableAlias = N'source',
						@SourceColumnName = @ColumnName,
						@ReinsertToken = @ReinsertToken,
						@AppendToList = @AppendToList;
				END

			FETCH NEXT FROM C_COLUMN_LIST INTO @ColumnOrdinal, @ColumnName, @IsPrimaryKey, @PrimaryKeyIndex;
		END
	CLOSE C_COLUMN_LIST;
	DEALLOCATE C_COLUMN_LIST;

	--remove unused tokens
	EXEC [Controller].[UtilRemoveTokens] @SQLStatment = @MergeStatement OUTPUT;

	IF (@DebugOnly = 1)
		PRINT @MergeStatement;
	ELSE
		BEGIN
			-- merge transformed data with model table
			DECLARE @ErrorNumber int = 0;

			EXEC(@MergeStatement);
			SET @ErrorNumber = @@ERROR;

			-- if the merege is successful, empty the changed keys table so that the changes are not included in the next transform
			IF (OBJECT_ID(@FQChangedKeysTableName) IS NOT NULL)
			AND(@ErrorNumber = 0)
				BEGIN				   
					DECLARE @FlushChangedKeysTableStatement nvarchar(512) = N'TRUNCATE TABLE ' + @FQChangedKeysTableName;
					EXEC(@FlushChangedKeysTableStatement);
				END
		END
END

--Update Audit Table With Row Counts
	SET @UpdateAuditTable = 
	N'UPDATE [Audit]
	SET [UpdateCount] = ISNULL([Temp].[UpdateCount],0),
	[EndTime] = GETDATE()
	FROM [Audit].[ModelExecutionStats] [Audit]
	LEFT JOIN (SELECT ExecutionID, COUNT(*) AS ''UpdateCount'' FROM ' + @TempTableName + ' WHERE [ChangeType] = ''Update'' GROUP BY ExecutionID) Temp
	ON ([Audit].[ExecutionID] = [Temp].[ExecutionID])
	WHERE ([Audit].[ModelTable] = ' + ''''  + @FactTableName  + '''' + ')
	AND ([Audit].[ExecutionID] = ' + CONVERT(NVARCHAR(30),@ExecutionID) + ')'
	
	EXEC(@UpdateAuditTable);


	SET @InsertAuditTable = 
	N'UPDATE [Audit]
	SET [InsertCount] = ISNULL([Temp].[InsertCount],0),
	[EndTime] = GETDATE()
	FROM [Audit].[ModelExecutionStats] [Audit]
	LEFT JOIN (SELECT ExecutionID, COUNT(*) AS ''InsertCount'' FROM ' + @TempTableName + ' WHERE [ChangeType] = ''Insert'' GROUP BY ExecutionID) Temp
	ON ([Audit].[ExecutionID] = [Temp].[ExecutionID])
	WHERE ([Audit].[ModelTable] = ' + ''''  + @FactTableName  + '''' + ')
	AND ([Audit].[ExecutionID] = ' + CONVERT(NVARCHAR(30),@ExecutionID) + ')'

	EXEC(@InsertAuditTable);
