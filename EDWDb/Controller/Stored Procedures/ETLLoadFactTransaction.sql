
CREATE PROCEDURE [Controller].[ETLLoadFactTransaction](
	@FactTableName nvarchar(128),
	@DebugOnly bit = 0
)
AS
BEGIN
	IF (@DebugOnly = 1)
		PRINT N'@FactTableName: ' + ISNULL(@FactTableName,N'NULL');

	DECLARE @FQTargetTableName nvarchar(256) = N'[Model].[' + @FactTableName + N']';
	DECLARE @FQTempTableName nvarchar(256) = N'[Transform].[' + @FactTableName + N'Changes]';
	DECLARE @FQChangedKeysTableName nvarchar(256) = N'[Transform].[' + @FactTableName + N'ChangedKeys]';

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

	DECLARE @InsertRecordStatement nvarchar(max) = N'
	MERGE ' + @FQTargetTableName + N' AS target
	USING (
		SELECT #ColumnName#
		FROM ' + @FQTempTableName + N'
	) AS source (#ColumnName#)
		#PrimaryKeyJoin#
	WHEN NOT MATCHED THEN	
		INSERT (#ColumnName#)
		VALUES (#SourceColumnRef#)
	OUTPUT
       $ACTION ChangeType,
       inserted.ExecutionID
    INTO ' + @TempTableName + ';';

	DECLARE C_COLUMN_LIST CURSOR FOR (
		SELECT
			[ColumnOrdinal], [ColumnName], [IsPrimaryKey], [PrimaryKeyIndex]
		FROM [Controller].[fnModelColumns](@FactTableName)
	)--note: the order of the columns is critical for token replacement
	ORDER BY [ColumnOrdinal] DESC, [PrimaryKeyIndex] DESC;

	OPEN C_COLUMN_LIST;
	DECLARE @ColumnOrdinal int, @ColumnName sysname, @IsPrimaryKey bit, @PrimaryKeyIndex int;
	FETCH NEXT FROM C_COLUMN_LIST INTO @ColumnOrdinal, @ColumnName, @IsPrimaryKey, @PrimaryKeyIndex;
	WHILE(@@FETCH_STATUS = 0)
		BEGIN
			SET @InsertRecordStatement = REPLACE(@InsertRecordStatement,
				N'#ColumnName#',
				(CASE WHEN (@ColumnOrdinal > 1) THEN N'#ColumnName#,' ELSE N'' END) + 
				N'[' + @ColumnName + N']'
			);

			SET @InsertRecordStatement = REPLACE(@InsertRecordStatement,
				N'#SourceColumnRef#',
				(CASE WHEN (@ColumnOrdinal > 1) THEN N'#SourceColumnRef#,' ELSE N'' END) + 
				N'source.[' + @ColumnName + N']'
			);

			IF(@IsPrimaryKey = 1)
				BEGIN
					SET @InsertRecordStatement = REPLACE(@InsertRecordStatement,
						N'#PrimaryKeyJoin#',
						(CASE WHEN (@PrimaryKeyIndex > 1) THEN N'#PrimaryKeyJoin#' + CHAR(10) + REPLICATE(CHAR(9),2) + N'AND' ELSE N'ON ' END) + 
						N'(target.[' + @ColumnName + N'] = source.[' + @ColumnName + N'])'
					);
				END

			FETCH NEXT FROM C_COLUMN_LIST INTO @ColumnOrdinal, @ColumnName, @IsPrimaryKey, @PrimaryKeyIndex;
		END
	CLOSE C_COLUMN_LIST;
	DEALLOCATE C_COLUMN_LIST;

	--remove unused tokens
	EXEC [Controller].[UtilRemoveTokens] @SQLStatment = @InsertRecordStatement OUTPUT;

	IF (@DebugOnly = 1)
		BEGIN
			PRINT 'Remember to flush the keys table after this code is run';
			PRINT @InsertRecordStatement;		
		END
	ELSE
		BEGIN
			-- merge transformed data with model table
			DECLARE @ErrorNumber int = 0;

			EXEC(@InsertRecordStatement);
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
	WHERE ([Audit].[ModelTable] = ' + '''' + @FactTableName  + '''' + ')
	AND ([Audit].[ExecutionID] = ' + CONVERT(NVARCHAR(30),@ExecutionID) + ')'

	EXEC(@InsertAuditTable);
