

CREATE PROCEDURE [Controller].[ETLTransformModelEntityChanges](
	@ModelEntityName nvarchar(64),
	@ModelEntityType nvarchar(16),
	@ExecutionID bigint = -1,
	@DebugOnly bit = 0
)
AS
BEGIN
	IF(@ModelEntityName IS NULL)
		BEGIN
			RAISERROR(50001,16,1,N'@ModelEntityName');
			RETURN;
		END

	IF(@ModelEntityType IS NULL)
		BEGIN
			RAISERROR(50001,16,1,N'@ModelEntityType');
			RETURN;
		END

	DECLARE @ModelEntityTableName sysname = @ModelEntityType + @ModelEntityName;
	IF (@DebugOnly = 1)
		PRINT N'@ModelEntityTableName: ' + @ModelEntityTableName;

	DECLARE @FQTargetTableName nvarchar(256) = N'[Model].[' + @ModelEntityTableName + N']';
	DECLARE @FQTempTableName nvarchar(256) = N'[Transform].[' + @ModelEntityTableName + N'Changes]';

	-- Persist the entity dependant transform views
	DECLARE @PreparePersistedViewsProcName nvarchar(256) = N'[Transform].[Prepare' + @ModelEntityTableName + N'PersistedViews]';
	IF (OBJECT_ID(@PreparePersistedViewsProcName) IS NOT NULL)
		EXEC(@PreparePersistedViewsProcName);

	-- Persist the entity transform view
	DECLARE @FQChangesViewName nvarchar(256) = N'[Transform].[' + @ModelEntityTableName + N'ChangesView]',
		@FQPersistedTableName nvarchar(256);
	EXEC [Controller].[UtilPersistView] @FQChangesViewName, @FQPersistedTableName OUTPUT, @DebugOnly;

	DECLARE @NewRecordQueryStatement nvarchar(max) = N'
WITH AllChangedRecords AS (
SELECT
	(CASE
		#QueryIsNewRecord#
		ELSE 0
	END) AS ''IsNewRecord''
	,(0 --default value if no HV attributes exist
		#QuerySCDBitmap#
	) AS ''SCDBitmap''
	,@ChangeDate AS ''StartDate''
	,NULL AS ''EndDate''
	,ExistingRecord.[IsLateArrivingMember]
	#QueryFKRef#
	#QueryBKRef#
	#QueryHVRef#
	#QueryCVRef#
FROM ' + @FQPersistedTableName + N' AS NewRecord WITH (NOLOCK)
#QueryFKJoin#
LEFT JOIN ' + @FQTargetTableName + N' AS ExistingRecord
	#QueryExistingJoinCondition#
	AND(ExistingRecord.[EndDate] IS NULL)
)';

	DECLARE @NewRecordInsertStatement nvarchar(max) = N'
INSERT INTO ' + @FQTempTableName + N'(
	#InsertPKColumn#
	,[ExecutionID]
	,[SCDBitmap]
	,[StartDate]
	,[EndDate]
	,[IsLateArrivingMember]
	#InsertFKColumn#
	#InsertBKColumn#
	#InsertHVColumn#
	#InsertCVColumn#
)
SELECT
	NEXT VALUE FOR [Controller].[' + @ModelEntityTableName + N'Key]
	,@ExecutionID
	,NewRecord.[SCDBitmap]
	,NewRecord.[StartDate]
	,NewRecord.[EndDate]
	,0
	#InsertFKRef#
	#InsertBKRef#
	#InsertHVRef#
	#InsertCVRef#
FROM AllChangedRecords AS NewRecord
WHERE (NewRecord.[IsNewRecord] = 1)
	OR(
			(NewRecord.[SCDBitmap] > 0)
		AND (NewRecord.[IsLateArrivingMember] = 0)
		)';

	DECLARE @ExistingRecordInsertStatement nvarchar(max) = N'		
INSERT INTO ' + @FQTempTableName + N'(
	#InsertExistingPKColumn#
	,[ExecutionID]
	,[SCDBitmap]
	,[StartDate]
	,[EndDate]
	,[IsLateArrivingMember]
	#InsertExistingBKColumn#
	#InsertExistingHVColumn#
	#InsertExistingCVColumn#
)
SELECT
	#InsertExistingPKRef#
	,ExistingRecord.[ExecutionID]
	,ExistingRecord.[SCDBitmap]
	,ExistingRecord.[StartDate]
	,(CASE
		WHEN (NewRecord.[StartDate] IS NOT NULL)
			AND (ExistingRecord.[EndDate] IS NULL)
		THEN @ChangeDate
		ELSE ExistingRecord.[EndDate]
	END)
	,0
	#InsertExistingBKRef#
	#InsertExistingHVRef#
	#InsertExistingCVRef#
FROM ' + @FQTargetTableName + N' AS ExistingRecord
-- join to related tables to get business keys
#InsertExistingFKJoin#
-- join to changes view to filter out all unchanged records 
INNER JOIN ' + @FQPersistedTableName + N' AS ChangedRecord
	#InsertExistingChangesJoinCondition#
-- join to related tables to get primary key
#InsertExistingChangesFKJoin#
-- join to temp table to identify members with new records 
LEFT JOIN ' + @FQTempTableName + N' AS NewRecord
	#InsertExistingNewRecordsJoinCondition#
';

	DECLARE C_COLUMN_LIST CURSOR FOR (
		SELECT
			[ColumnOrdinal],
			[ColumnName],
			[KeyType],
			[KeyTypeIndex],
			[AttributeType],
			[AttributeTypeIndex],
			[IsPrimaryKey],
			[IsForeignKey],
			[ForeignKeyIndex],
			[ReferencedTableName],
			[IsMetaData]
		FROM [Controller].[fnModelColumns](@ModelEntityTableName)
	)--note: the order of the columns is critical for token replacement
	ORDER BY [ColumnOrdinal] DESC;
	OPEN C_COLUMN_LIST;

	DECLARE @ColumnOrdinal int, @ColumnName sysname, @KeyType nvarchar(16), @KeyTypeIndex int, @AttributeType nvarchar(16), @AttributeTypeIndex int, @IsPrimaryKey bit, @IsForeignKey bit, @ForeignKeyIndex int, @ReferencedTableName sysname, @IsMetaData bit;
	FETCH NEXT FROM C_COLUMN_LIST INTO @ColumnOrdinal, @ColumnName, @KeyType, @KeyTypeIndex, @AttributeType, @AttributeTypeIndex, @IsPrimaryKey, @IsForeignKey, @ForeignKeyIndex, @ReferencedTableName, @IsMetaData;
	WHILE(@@FETCH_STATUS = 0)
		BEGIN
			DECLARE @ChangesTableAlias sysname = CAST(N'ChangedRecord' AS sysname);
			DECLARE @ExistingTableAlias sysname = CAST(N'ExistingRecord' AS sysname);
			DECLARE @ReferencedModelEntityTableName sysname = @ReferencedTableName;
			DECLARE @ModelEntityTableBKAlias sysname = CAST(@ReferencedTableName + N'_' + @ColumnName + N'_BK' AS sysname);
			DECLARE @ModelEntityTablePKAlias sysname = CAST(@ReferencedTableName + N'_' + @ColumnName + N'_PK' AS sysname);
			DECLARE @ModelEntityPKColumnName sysname = [Controller].[fnModelEntityPrimaryKey](@ReferencedTableName);

			IF (@IsPrimaryKey = 1)
				BEGIN
					EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
						@DMLStatement = @NewRecordInsertStatement OUTPUT,
						@Token = N'#InsertPKColumn#',
						@ColumnName = @ColumnName;

					EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
						@DMLStatement = @ExistingRecordInsertStatement OUTPUT,
						@Token = N'#InsertExistingPKColumn#',
						@ColumnName = @ColumnName;

					EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
						@DMLStatement = @ExistingRecordInsertStatement OUTPUT,
						@Token = N'#InsertExistingPKRef#',
						@ColumnName = @ColumnName,
						@TableAlias = @ExistingTableAlias;
				END

			IF (@IsForeignKey = 1)
				BEGIN
					DECLARE @ReinsertFKToken bit = (CASE WHEN (@ForeignKeyIndex > 1) THEN 1 ELSE 0 END);

					EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
						@DMLStatement = @NewRecordQueryStatement OUTPUT,
						@Token = N'#QueryFKRef#',
						@TableAlias = @ModelEntityTableBKAlias,
						@ColumnName = @ModelEntityPKColumnName,
						@ColumnAlias = @ColumnName,
						@ReinsertToken = @ReinsertFKToken,
						@AppendToList = 1,
						@IsModelEntityKey = 1;

					EXEC [Controller].[ETLReplaceTokenForModelEntityBKJoin]
						@DMLStatement = @NewRecordQueryStatement OUTPUT,
						@Token = N'#QueryFKJoin#',
						@ColumnName = @ColumnName,
						@TableAlias = N'NewRecord',
						@ModelEntityTableName = @ReferencedModelEntityTableName,
						@ModelEntityTableAlias = @ModelEntityTableBKAlias,
						@ReinsertToken = @ReinsertFKToken;

					EXEC [Controller].[ETLReplaceTokenForModelEntityBKJoin]
						@DMLStatement = @ExistingRecordInsertStatement OUTPUT,
						@Token = N'#InsertExistingChangesFKJoin#',
						@ColumnName = @ColumnName,
						@TableAlias = @ChangesTableAlias,
						@ModelEntityTableName = @ReferencedModelEntityTableName,
						@ModelEntityTableAlias = @ModelEntityTableBKAlias,
						@ReinsertToken = @ReinsertFKToken;

					EXEC [Controller].[ETLReplaceTokenForModelEntityPKJoin]
						@DMLStatement = @ExistingRecordInsertStatement OUTPUT,
						@Token = N'#InsertExistingFKJoin#',
						@ColumnName = @ColumnName,
						@TableAlias = @ExistingTableAlias,
						@ReferencedColumnName = @ModelEntityPKColumnName,
						@ReferencedTableName = @ReferencedModelEntityTableName,
						@ReferencedTableAlias = @ModelEntityTablePKAlias,
						@ReinsertToken = @ReinsertFKToken;

					EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
						@DMLStatement = @NewRecordInsertStatement OUTPUT,
						@Token = N'#InsertFKColumn#',
						@ColumnName = @ColumnName,
						@ReinsertToken = @ReinsertFKToken,
						@AppendToList = 1;

					EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
						@DMLStatement = @NewRecordInsertStatement OUTPUT,
						@Token = N'#InsertFKRef#',
						@ColumnName = @ColumnName,
						@TableAlias = N'NewRecord',
						@ReinsertToken = @ReinsertFKToken,
						@AppendToList = 1;
				END

			IF (CHARINDEX(N'BK',@KeyType,1) > 0)
				BEGIN
					DECLARE @ReinsertKeyToken bit = (CASE WHEN (@KeyTypeIndex > 1) THEN 1 ELSE 0 END);

					SET @NewRecordQueryStatement = REPLACE(@NewRecordQueryStatement,
						N'#QueryIsNewRecord#',
						--only one column needs to be NULL for the IsNewMember to be true
						--(none of the business keys can be NULL)
						--so we don't re-insert the token
						N'WHEN (ExistingRecord.[' + @ColumnName + N'] IS NULL) THEN 1'
					);

					IF (@IsForeignKey = 1)
						BEGIN --TODO: remove, this should never occur (i.e. a BK being an FK)
							EXEC [Controller].[ETLReplaceTokenJoinCondition]
								@DMLStatement = @NewRecordQueryStatement OUTPUT,
								@Token = N'#QueryExistingJoinCondition#',
								@ColumnName = @ColumnName,
								@TableAlias = @ExistingTableAlias,
								@ReferencedColumnName = @ModelEntityPKColumnName,
								@ReferencedTableAlias = @ReferencedTableName,
								@ReinsertToken = @ReinsertKeyToken;
						END
					ELSE
						BEGIN
							EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
								@DMLStatement = @NewRecordQueryStatement OUTPUT,
								@Token = N'#QueryBKRef#',
								@ColumnName = @ColumnName,
								@TableAlias = N'NewRecord',
								@ReinsertToken = @ReinsertKeyToken,
								@AppendToList = 1;

							EXEC [Controller].[ETLReplaceTokenJoinCondition]
								@DMLStatement = @NewRecordQueryStatement OUTPUT,
								@Token = N'#QueryExistingJoinCondition#',
								@ColumnName = @ColumnName,
								@TableAlias = @ExistingTableAlias,
								@ReferencedColumnName = @ColumnName,
								@ReferencedTableAlias = N'NewRecord',
								@ReinsertToken = @ReinsertKeyToken;

							EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
								@DMLStatement = @NewRecordInsertStatement OUTPUT,
								@Token = N'#InsertBKColumn#',
								@ColumnName = @ColumnName,
								@ReinsertToken = @ReinsertKeyToken,
								@AppendToList = 1;

							EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
								@DMLStatement = @NewRecordInsertStatement OUTPUT,
								@Token = N'#InsertBKRef#',
								@ColumnName = @ColumnName,
								@TableAlias = N'NewRecord',
								@ReinsertToken = @ReinsertKeyToken,
								@AppendToList = 1;

							EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
								@DMLStatement = @ExistingRecordInsertStatement OUTPUT,
								@Token = N'#InsertExistingBKColumn#',
								@ColumnName = @ColumnName,
								@ReinsertToken = @ReinsertKeyToken,
								@AppendToList = 1;

							EXEC [Controller].[ETLReplaceTokenForSCDColumn]
								@DMLStatement = @ExistingRecordInsertStatement OUTPUT,
								@Token = N'#InsertExistingBKRef#',
								@ColumnName = @ColumnName,
								@ChangesTableAlias = @ChangesTableAlias,
								@ExistingTableAlias = @ExistingTableAlias,
								@ReinsertToken = @ReinsertKeyToken,
								@AppendToList = 1;
						END

					EXEC [Controller].[ETLReplaceTokenJoinCondition]
						@DMLStatement = @ExistingRecordInsertStatement OUTPUT,
						@Token = N'#InsertExistingChangesJoinCondition#',
						@ColumnName = @ColumnName,
						@TableAlias = @ExistingTableAlias,
						@ReferencedColumnName = @ColumnName,
						@ReferencedTableAlias = @ChangesTableAlias,
						@ReinsertToken = @ReinsertKeyToken;

					EXEC [Controller].[ETLReplaceTokenJoinCondition]
						@DMLStatement = @ExistingRecordInsertStatement OUTPUT,
						@Token = N'#InsertExistingNewRecordsJoinCondition#',
						@ColumnName = @ColumnName,
						@TableAlias = @ExistingTableAlias,
						@ReferencedColumnName = @ColumnName,
						@ReferencedTableAlias = N'NewRecord',
						@ReinsertToken = @ReinsertKeyToken;
				END

			IF (@AttributeType = N'HV')
				BEGIN
					DECLARE @ReinsertHVAttributeToken bit = (CASE WHEN (@AttributeTypeIndex > 1) THEN 1 ELSE 0 END);
					DECLARE @ColumnBit int = 1;

					IF (@IsForeignKey = 1)
						BEGIN
							EXEC [Controller].[ETLReplaceTokenSCDBitmap]
								@DMLStatement = @NewRecordQueryStatement OUTPUT,
								@Token = N'#QuerySCDBitmap#',
								@ColumnName = @ColumnName,
								@ColumnBit = @ColumnBit,
								@IsForeignKey = @IsForeignKey,
								@ChangesTableAlias = @ModelEntityTableBKAlias,
								@ChangesColumnName = @ModelEntityPKColumnName,
								@ExistingTableAlias = @ExistingTableAlias,
								@ReinsertToken = @ReinsertHVAttributeToken;

							EXEC [Controller].[ETLReplaceTokenForSCDColumnModelEntityValue]
								@DMLStatement = @ExistingRecordInsertStatement OUTPUT,
								@Token = N'#InsertExistingHVRef#',
								@TargetColumnName = @ColumnName,
								@SourceColumnName = @ModelEntityPKColumnName,
								@ChangesTableAlias = @ModelEntityTableBKAlias,
								@ExistingTableAlias = @ExistingTableAlias,
								@ReinsertToken = @ReinsertHVAttributeToken,
								@AppendToList = 1,
								@IsModelEntityKey = 1;
						END
					ELSE
						BEGIN
							EXEC [Controller].[ETLReplaceTokenSCDBitmap]
								@DMLStatement = @NewRecordQueryStatement OUTPUT,
								@Token = N'#QuerySCDBitmap#',
								@ColumnName = @ColumnName,
								@ColumnBit = @ColumnBit,
								@IsForeignKey = @IsForeignKey,
								@ChangesTableAlias = N'NewRecord',
								@ChangesColumnName = @ColumnName,
								@ExistingTableAlias = @ExistingTableAlias,
								@ReinsertToken = @ReinsertHVAttributeToken;

							EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
								@DMLStatement = @NewRecordQueryStatement OUTPUT,
								@Token = N'#QueryHVRef#',
								@ColumnName = @ColumnName,
								@TableAlias = N'NewRecord',
								@ReinsertToken = @ReinsertHVAttributeToken,
								@AppendToList = 1;

							EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
								@DMLStatement = @NewRecordInsertStatement OUTPUT,
								@Token = N'#InsertHVColumn#',
								@ColumnName = @ColumnName,
								@ReinsertToken = @ReinsertHVAttributeToken,
								@AppendToList = 1;

							EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
								@DMLStatement = @NewRecordInsertStatement OUTPUT,
								@Token = N'#InsertHVRef#',
								@ColumnName = @ColumnName,
								@TableAlias = N'NewRecord',
								@ReinsertToken = @ReinsertHVAttributeToken,
								@AppendToList = 1;

							EXEC [Controller].[ETLReplaceTokenForSCDColumnModelEntityValue]
								@DMLStatement = @ExistingRecordInsertStatement OUTPUT,
								@Token = N'#InsertExistingHVRef#',
								@TargetColumnName = @ColumnName,
								@SourceColumnName = @ColumnName,
								@ChangesTableAlias = @ChangesTableAlias,
								@ExistingTableAlias = @ExistingTableAlias,
								@ReinsertToken = @ReinsertHVAttributeToken,
								@AppendToList = 1;
						END

					EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
						@DMLStatement = @ExistingRecordInsertStatement OUTPUT,
						@Token = N'#InsertExistingHVColumn#',
						@ColumnName = @ColumnName,
						@ReinsertToken = @ReinsertHVAttributeToken,
						@AppendToList = 1;
				END

			IF (@AttributeType = N'CV')
			AND(ISNULL(CHARINDEX(N'BK',@KeyType,1),0) = 0)
				BEGIN
					DECLARE @ReinsertCVAttributeToken bit = (CASE WHEN (@AttributeTypeIndex > 1) THEN 1 ELSE 0 END);

					IF (@IsForeignKey = 1)
						BEGIN
							EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
								@DMLStatement = @ExistingRecordInsertStatement OUTPUT,
								@Token = N'#InsertExistingCVRef#',
								@ColumnName = @ColumnName,
								@TableAlias = @ModelEntityTableBKAlias,
								@ReinsertToken = @ReinsertCVAttributeToken,
								@AppendToList = 1;
						END
					ELSE
						BEGIN
							EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
								@DMLStatement = @NewRecordQueryStatement OUTPUT,
								@Token = N'#QueryCVRef#',
								@ColumnName = @ColumnName,
								@TableAlias = N'NewRecord',
								@ReinsertToken = @ReinsertCVAttributeToken,
								@AppendToList = 1;

							EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
								@DMLStatement = @NewRecordInsertStatement OUTPUT,
								@Token = N'#InsertCVColumn#',
								@ColumnName = @ColumnName,
								@ReinsertToken = @ReinsertCVAttributeToken,
								@AppendToList = 1;

							EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
								@DMLStatement = @NewRecordInsertStatement OUTPUT,
								@Token = N'#InsertCVRef#',
								@ColumnName = @ColumnName,
								@TableAlias = N'NewRecord',
								@ReinsertToken = @ReinsertCVAttributeToken,
								@AppendToList = 1;

							EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
								@DMLStatement = @ExistingRecordInsertStatement OUTPUT,
								@Token = N'#InsertExistingCVRef#',
								@ColumnName = @ColumnName,
								@TableAlias = @ChangesTableAlias,
								@ReinsertToken = @ReinsertCVAttributeToken,
								@AppendToList = 1;
						END

					EXEC [Controller].[ETLReplaceTokenForModelEntityColumn]
						@DMLStatement = @ExistingRecordInsertStatement OUTPUT,
						@Token = N'#InsertExistingCVColumn#',
						@ColumnName = @ColumnName,
						@ReinsertToken = @ReinsertCVAttributeToken,
						@AppendToList = 1;
				END

			FETCH NEXT FROM C_COLUMN_LIST INTO @ColumnOrdinal, @ColumnName, @KeyType, @KeyTypeIndex, @AttributeType, @AttributeTypeIndex, @IsPrimaryKey, @IsForeignKey, @ForeignKeyIndex, @ReferencedTableName, @IsMetaData;
		END
	CLOSE C_COLUMN_LIST;
	DEALLOCATE C_COLUMN_LIST;

	--remove unused tokens
	EXEC [Controller].[UtilRemoveTokens] @NewRecordQueryStatement OUTPUT;
	EXEC [Controller].[UtilRemoveTokens] @NewRecordInsertStatement OUTPUT;
	EXEC [Controller].[UtilRemoveTokens] @ExistingRecordInsertStatement OUTPUT;

	DECLARE @CompleteExecutionStatement nvarchar(max) =
		@NewRecordQueryStatement +
		@NewRecordInsertStatement + 
		@ExistingRecordInsertStatement;

	IF (@DebugOnly = 1)
		BEGIN
			PRINT CAST(@NewRecordQueryStatement AS varchar(max));
			PRINT CAST(@NewRecordInsertStatement AS varchar(max));
			PRINT CAST(@ExistingRecordInsertStatement AS varchar(max));
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

