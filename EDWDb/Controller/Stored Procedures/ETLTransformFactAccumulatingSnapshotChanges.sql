



CREATE PROCEDURE [Controller].[ETLTransformFactAccumulatingSnapshotChanges](
	@TableName sysname,
	@ExecutionID bigint = -1,
	@DebugOnly bit = 0
)
AS
BEGIN
	IF (@DebugOnly = 1)
		PRINT N'@TableName: ' + @TableName;
	ELSE
		BEGIN
			IF(@TableName IS NULL)
				BEGIN
					RAISERROR(50001,16,1,'@TableName');
					RETURN;
				END
		END

	DECLARE
		@FQTargetTableName nvarchar(256) = N'[Model].[' + @TableName + N']',
		@FQTempTableName nvarchar(256) = N'[Transform].[' + @TableName + N'Changes]',
		@FQSourceViewName nvarchar(256) = N'[Transform].[' + @TableName + N'ChangesView]';

	DECLARE @InsertStatement nvarchar(max) = N'
INSERT INTO ' + @FQTempTableName + N'(
	[ExecutionID]
	#FKColumnName#
	#ColumnName#
)
SELECT
	@ExecutionID
	#FKColumnValue#
	#ColumnValue#
FROM ' + @FQSourceViewName + N' AS NewRecord WITH (NOLOCK)
#NewRecordPredicates#
';

	DECLARE C_COLUMN_LIST SCROLL CURSOR FOR (
		SELECT
			[ColumnOrdinal],
			[ColumnName],
			[FactType],
			[FactTypeIndex],
			[ColumnType],
			[ColumnTypeIndex],
			[IsPrimaryKey],
			[PrimaryKeyIndex],
			[IsForeignKey],
			[ForeignKeyIndex],
			[ReferencedTableName]
		FROM [Controller].[fnModelColumns](@TableName)
		WHERE  (ISNULL([IsMetaData],0) = 0)
	)--note: the order of the columns is critical for token replacement
	ORDER BY [ColumnOrdinal] DESC;

	OPEN C_COLUMN_LIST;
	DECLARE @ColumnOrdinal int, @ColumnName sysname, @FactType nvarchar(16), @FactTypeIndex int, @ColumnType nvarchar(16), @ColumnTypeIndex int, @IsPrimaryKey bit, @PrimaryKeyIndex int, @IsForeignKey bit, @ForeignKeyIndex int, @ReferencedTableName sysname;
	FETCH NEXT FROM C_COLUMN_LIST INTO @ColumnOrdinal, @ColumnName, @FactType, @FactTypeIndex, @ColumnType, @ColumnTypeIndex, @IsPrimaryKey, @PrimaryKeyIndex, @IsForeignKey, @ForeignKeyIndex, @ReferencedTableName;
	WHILE(@@FETCH_STATUS = 0)
		BEGIN
			DECLARE @ChangesTableAlias sysname = CAST(N'ChangedRecord' AS sysname);
			DECLARE @NewTableAlias sysname = CAST(N'NewRecord' AS sysname);
			DECLARE @ExistingTableAlias sysname = CAST(N'ExistingRecord' AS sysname);
			DECLARE @DimensionTableName sysname = @ReferencedTableName;
			DECLARE @DimensionTableBKAlias sysname = CAST(@ReferencedTableName + N'_' + @ColumnName + N'_BK' AS sysname);
			DECLARE @DimensionTablePKAlias sysname = CAST(@ReferencedTableName + N'_' + @ColumnName + N'_PK' AS sysname);
			DECLARE @DimensionPKColumnName sysname = [Controller].[fnModelEntityPrimaryKey](@ReferencedTableName);

			IF (@IsForeignKey = 1)
				BEGIN
					DECLARE @ReinsertFKToken bit = (CASE WHEN (@ForeignKeyIndex > 1) THEN 1 ELSE 0 END);


					EXEC [Controller].[ETLReplaceTokenForModelEntityVersions]
						@DMLStatement = @InsertStatement OUTPUT,
						@Token = N'#NewRecordPredicates#',
						@ColumnName = @ColumnName,
						@TableAlias = N'NewRecord',
						@ModelEntityTableName = @DimensionTableName,
						@ModelEntityTableAlias = @DimensionTableBKAlias,
						@ReinsertToken = @ReinsertFKToken,
						@ModelParentEntityTableName = @TableName,
						@ModelEntityTablePK = @DimensionPKColumnName;


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
			ELSE --All non-foreign key columns
				BEGIN
					DECLARE @ReinsertColumnToken bit = (CASE WHEN (@ColumnOrdinal > 1) THEN 1 ELSE 0 END);

					EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
						@DMLStatement = @InsertStatement OUTPUT,
						@Token = N'#ColumnName#',
						@ColumnName = @ColumnName,
						@ReinsertToken = @ReinsertColumnToken,
						@AppendToList = 1;

					EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
						@DMLStatement = @InsertStatement OUTPUT,
						@Token = N'#ColumnValue#',
						@TableAlias = N'NewRecord',
						@ColumnName = @ColumnName,
						@ReinsertToken = @ReinsertColumnToken,
						@AppendToList = 1;
				END


			FETCH NEXT FROM C_COLUMN_LIST INTO @ColumnOrdinal, @ColumnName, @FactType, @FactTypeIndex, @ColumnType, @ColumnTypeIndex, @IsPrimaryKey, @PrimaryKeyIndex, @IsForeignKey, @ForeignKeyIndex, @ReferencedTableName;
		END


	CLOSE C_COLUMN_LIST;
	DEALLOCATE C_COLUMN_LIST;

	--remove unused tokens
	EXEC [Controller].[UtilRemoveTokens] @InsertStatement OUTPUT;

	IF (@DebugOnly = 1)
		BEGIN
			SELECT @InsertStatement;
			PRINT @InsertStatement;
		END
	ELSE
		BEGIN
			DECLARE @ChangeDate datetime = GETDATE();
			EXEC sp_executesql @InsertStatement,
				N'@ChangeDate datetime, @ExecutionID bigint',
				@ChangeDate, @ExecutionID;
		END

	RETURN(0);
END



