
CREATE PROCEDURE [Controller].[ETLTransformFactFactlessChanges](
	@FactTableName sysname,
	@ExecutionID bigint = -1,
	@DebugOnly bit = 0
)
AS
BEGIN
	IF (@DebugOnly = 1)
		PRINT N'@FactTableName: ' + @FactTableName;
	ELSE
		BEGIN
			IF(@FactTableName IS NULL)
				BEGIN
					RAISERROR(50001,16,1,'@FactTableName');
					RETURN;
				END
		END

	DECLARE @FQTargetTableName nvarchar(256) = N'[Model].[' + @FactTableName + N']';
	DECLARE @FQTempTableName nvarchar(256) = N'[Transform].[' + @FactTableName + N'Changes]';
	DECLARE @FQSourceViewName nvarchar(256) = N'[Transform].[' + @FactTableName + N'ChangesView]';

	DECLARE @InsertStatement nvarchar(max) = N'
	INSERT INTO ' + @FQTempTableName + N'(
		[ExecutionID]
		#FKColumnName#
	)
	SELECT
		@ExecutionID
		#FKColumnValue#
	FROM ' + @FQSourceViewName + N' AS Changes WITH (NOLOCK)
	#FKJoin#
	';

	DECLARE C_COLUMN_LIST CURSOR FOR (
		SELECT
			[ColumnOrdinal], [ColumnName], [IsForeignKey], [ForeignKeyIndex], [ReferencedTableName]
		FROM [Controller].[fnModelColumns](@FactTableName)
	)--note: the order of the columns is critical for token replacement
	ORDER BY [ColumnOrdinal] DESC, [ForeignKeyIndex] DESC;

	OPEN C_COLUMN_LIST;
	DECLARE @ColumnOrdinal int, @ColumnName sysname, @IsForeignKey bit, @ForeignKeyIndex int, @ReferencedTableName sysname;
	FETCH NEXT FROM C_COLUMN_LIST INTO @ColumnOrdinal, @ColumnName, @IsForeignKey, @ForeignKeyIndex, @ReferencedTableName;
	WHILE(@@FETCH_STATUS = 0)
		BEGIN
			DECLARE @DimensionTableBKAlias sysname = CAST(@ReferencedTableName + N'_' + @ColumnName + N'_BK' AS sysname);
			DECLARE @DimensionPKColumnName sysname = [Controller].[fnModelEntityPrimaryKey](@ReferencedTableName);

			IF (@IsForeignKey = 1)
				BEGIN
					DECLARE @ReinsertFKToken bit = (CASE WHEN (@ForeignKeyIndex > 1) THEN 1 ELSE 0 END);

					EXEC [Controller].[ETLReplaceTokenForModelEntityBKJoin]
						@DMLStatement = @InsertStatement OUTPUT,
						@Token = N'#FKJoin#',
						@ColumnName = @ColumnName,
						@TableAlias = N'Changes',
						@ModelEntityTableName = @ReferencedTableName,
						@ModelEntityTableAlias = @DimensionTableBKAlias,
						@ReinsertToken = @ReinsertFKToken;

					EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
						@DMLStatement = @InsertStatement OUTPUT,
						@Token = N'#FKColumnName#',
						@ColumnName = @ColumnName,
						@ReinsertToken = @ReinsertFKToken,
						@AppendToList = 1;

					EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
						@DMLStatement = @InsertStatement OUTPUT,
						@Token = N'#FKColumnValue#',
						@TableAlias = @DimensionTableBKAlias,
						@ColumnName = @DimensionPKColumnName,
						@ReinsertToken = @ReinsertFKToken,
						@AppendToList = 1,
						@IsModelEntityKey = 1;
				END

			FETCH NEXT FROM C_COLUMN_LIST INTO @ColumnOrdinal, @ColumnName, @IsForeignKey, @ForeignKeyIndex, @ReferencedTableName;
		END
	CLOSE C_COLUMN_LIST;
	DEALLOCATE C_COLUMN_LIST;

	--remove unused tokens
	EXEC [Controller].[UtilRemoveTokens] @SQLStatment = @InsertStatement OUTPUT;

	DECLARE @CompleteExecutionStatement nvarchar(max) =
		@InsertStatement;

	IF (@DebugOnly = 1)
		BEGIN
			PRINT @InsertStatement;
		END
	ELSE
		BEGIN
			DECLARE @ChangeDate datetime = GETDATE();
			EXEC sp_executesql @CompleteExecutionStatement,
				N'@ChangeDate datetime, @ExecutionID bigint',
				@ChangeDate, @ExecutionID;
		END

	RETURN(0);
END
