

CREATE PROCEDURE [Controller].[ETLLoadModelEntity](
	@ModelEntityName nvarchar(64),
	@ModelEntityType nvarchar(16),
	@DebugOnly bit = 0
)
AS
BEGIN
	IF (@DebugOnly = 1)
		PRINT N'@ModelEntityName: ' + ISNULL(@ModelEntityName,N'NULL');
	ELSE
		BEGIN
			IF(@ModelEntityName IS NULL)
				BEGIN
					RAISERROR(50001,16,1,'@ModelEntityName');
					RETURN;
				END
		END

	DECLARE @ExecutionId BIGINT;
	SELECT @ExecutionId = ISNULL(MAX([execution_id]), - 1) FROM [SSISDB].[catalog].[executions] WHERE package_name = 'Controller.dtsx'	AND STATUS = 2;

	DECLARE @ModelEntityTableName nvarchar(128) = @ModelEntityType + @ModelEntityName;
	DECLARE @FQModelEntityTableName nvarchar(256) = N'[Model].[' + @ModelEntityTableName + N']';
	DECLARE @FQModelEntityChangesTable nvarchar(256) = N'[Transform].[' + @ModelEntityTableName + N'Changes]';
	DECLARE @FQModelEntityChangedKeysTableName nvarchar(256) = N'[Transform].[' + @ModelEntityTableName + N'ChangedKeys]';
	DECLARE @TempTableName NVARCHAR(128) = 'Transform.' + @ModelEntityType + @ModelEntityName + 'Temp';
	DECLARE @DropTempTable NVARCHAR(128);
	DECLARE @CreateTempTable NVARCHAR(128);
	DECLARE @UpdateAuditTable NVARCHAR(500);
	DECLARE @InsertAuditTable NVARCHAR(500);

	SET @DropTempTable = 'DROP TABLE ' + @TempTableName

	SET @CreateTempTable = 'CREATE TABLE '  + @TempTableName + '(		ChangeType NVARCHAR(10)
		,ExecutionID BIGINT NOT NULL
		);'

	IF OBJECT_ID(@TempTableName) IS NOT NULL
	EXEC (@DropTempTable);

	EXEC (@CreateTempTable);

	
	DECLARE @InsertModelEntityMembersStatement nvarchar(max) = N'
	--update late arriving members
	MERGE ' + @FQModelEntityTableName + N' AS target
	USING (
		SELECT #ColumnName#
		FROM ' + @FQModelEntityChangesTable + N'
	) AS source (#ColumnName#)
		#PrimaryKeyJoin#
		AND (target.[IsLateArrivingMember] = 1)
	WHEN MATCHED THEN 
		UPDATE SET
			#ColumnUpdate#
	OUTPUT
       $ACTION ChangeType,' +
       CONVERT(NVARCHAR(20),@ExecutionID) + '
    INTO ' + @TempTableName + ';
	
	--update type1 attributes and add new members
	MERGE ' + @FQModelEntityTableName + N' AS target
	USING (
		SELECT #ColumnName#
		FROM ' + @FQModelEntityChangesTable + N'
	) AS source (#ColumnName#)
		#PrimaryKeyJoin#
	WHEN MATCHED AND 
	(
	 ISNULL([Target].[EndDate],''01 JAN 1900'') <> ISNULL(source.[EndDate],''01 JAN 1900'')
	#Type1ColumnPredicates#
	) 
	THEN	UPDATE SET
			[EndDate] = source.[EndDate]
			#Type1ColumnUpdate#
	WHEN NOT MATCHED THEN	
		INSERT (#ColumnName#)
		VALUES (#SourceColumnRef#)
	OUTPUT
       $ACTION ChangeType,' +
       CONVERT(NVARCHAR(30),@ExecutionID) + '
    INTO ' + @TempTableName + ';';

	DECLARE C_COLUMN_LIST CURSOR FOR (
		SELECT
			[ColumnName],
			[ColumnOrdinal],
			[AttributeType],
			[AttributeTypeIndex],
			[IsPrimaryKey]
		FROM [Controller].[fnModelColumns](@ModelEntityTableName)
		WHERE ([AttributeType] IS NULL)
			OR([AttributeType] <> 'DV')
	) ORDER BY [ColumnOrdinal] DESC;

	OPEN C_COLUMN_LIST;
	DECLARE @ColumnName sysname, @ColumnOrdinal int, @AttributeType nvarchar(16), @AttributeTypeIndex int, @IsPrimaryKey bit;
	FETCH NEXT FROM C_COLUMN_LIST INTO @ColumnName, @ColumnOrdinal, @AttributeType, @AttributeTypeIndex, @IsPrimaryKey;
	WHILE(@@FETCH_STATUS = 0)
		BEGIN

		DECLARE @IsNullable BIT = 0;
		DECLARE @NullableReplacementValue VARCHAR(64);


		SELECT @IsNullable = CASE 
				WHEN [SystemTable].[IS_NULLABLE] = 'YES'
					THEN 1
				ELSE 0
				END
		FROM INFORMATION_SCHEMA.COLUMNS SystemTable
		CROSS APPLY (
			SELECT [AttributeType]
			FROM [Controller].[fnModelColumns]([SystemTable].[TABLE_NAME])
			WHERE [ColumnName] = [SystemTable].[COLUMN_NAME]
			) CurrentColumns
		CROSS APPLY (
			SELECT [TableType]
			FROM [Controller].[fnModelTables](SystemTable.TABLE_NAME)
			) CurrentTable
		WHERE [SystemTable].[IS_NULLABLE] = 'YES'
			AND [CurrentColumns].[AttributeType] = 'CV'
			AND [CurrentTable].[TableType] = 'HD'
			AND [SystemTable].[TABLE_SCHEMA] = 'Model'
			AND [SystemTable].[COLUMN_NAME] <> 'EndDate'
			AND [SystemTable].[COLUMN_NAME] = @ColumnName
			AND [SystemTable].[TABLE_NAME] = 	@ModelEntityType + @ModelEntityName;

		SELECT @NullableReplacementValue = CASE 
				WHEN [SystemTable].[DATA_TYPE] IN (
						'bit'
						,'int'
						,'decimal'
						,'numeric'
						)
					THEN '0'
				ELSE CASE 
						WHEN [SystemTable].[DATA_TYPE] IN (
								'date'
								,'datetime'
								)
							THEN '''01 JAN 1900'''
						ELSE CASE 
								WHEN [SystemTable].[DATA_TYPE] IN ('time')
									THEN '''00:00:00'''
								ELSE ''''''
								END
						END
				END
		FROM INFORMATION_SCHEMA.COLUMNS SystemTable
		CROSS APPLY (
			SELECT [AttributeType]
			FROM [Controller].[fnModelColumns]([SystemTable].[TABLE_NAME])
			WHERE [ColumnName] = [SystemTable].[COLUMN_NAME]
			) CurrentColumns
		CROSS APPLY (
			SELECT [TableType]
			FROM [Controller].[fnModelTables](SystemTable.TABLE_NAME)
			) CurrentTable
		WHERE [SystemTable].[IS_NULLABLE] = 'YES'
			AND [CurrentColumns].[AttributeType] = 'CV'
			AND [CurrentTable].[TableType] = 'HD'
			AND [SystemTable].[TABLE_SCHEMA] = 'Model'
			AND [SystemTable].[COLUMN_NAME] <> 'EndDate'
			AND [SystemTable].[COLUMN_NAME] = @ColumnName
			AND [SystemTable].[TABLE_NAME] = 	@ModelEntityType + @ModelEntityName;



			--update all columns for late arriving member
			SET @InsertModelEntityMembersStatement = REPLACE(@InsertModelEntityMembersStatement,
				N'#ColumnUpdate#',
				(CASE WHEN (@ColumnOrdinal > 1) THEN N'#ColumnUpdate#' + CHAR(10) + REPLICATE(CHAR(9),3) + N',' ELSE N'' END) + 
				N'target.[' + @ColumnName + N'] = source.[' + @ColumnName + N']'
			);

			SET @InsertModelEntityMembersStatement = REPLACE(@InsertModelEntityMembersStatement,
				N'#ColumnName#',
				(CASE WHEN (@ColumnOrdinal > 1) THEN N'#ColumnName#,' ELSE N'' END) + 
				N'[' + @ColumnName + N']'
			);

			SET @InsertModelEntityMembersStatement = REPLACE(@InsertModelEntityMembersStatement,
				N'#SourceColumnRef#',
				(CASE WHEN (@ColumnOrdinal > 1) THEN N'#SourceColumnRef#,' ELSE N'' END) + 
				N'source.[' + @ColumnName + N']'
			);

			IF(@IsPrimaryKey = 1)
				BEGIN
					SET @InsertModelEntityMembersStatement = REPLACE(@InsertModelEntityMembersStatement,
						N'#PrimaryKeyJoin#',
						N'ON (target.[' + @ColumnName + N'] = source.[' + @ColumnName + N'])'
					);
				END


				IF(@AttributeType = N'CV')
				  IF (@IsNullable = 0)
						BEGIN
							SET @InsertModelEntityMembersStatement = REPLACE(@InsertModelEntityMembersStatement,
								N'#Type1ColumnPredicates#',
								(CASE WHEN (@AttributeTypeIndex > 1) THEN N'#Type1ColumnPredicates#' + CHAR(10) + REPLICATE(CHAR(9),3) ELSE N'' END) + 
								N'OR [Target].[' + @ColumnName + N'] <> source.[' + @ColumnName + N']'
							);
						END
					ELSE
						BEGIN
							SET @InsertModelEntityMembersStatement = REPLACE(@InsertModelEntityMembersStatement,
								N'#Type1ColumnPredicates#',
								(CASE WHEN (@AttributeTypeIndex > 1) THEN N'#Type1ColumnPredicates#' + CHAR(10) + REPLICATE(CHAR(9),3) ELSE N'' END) + 
								N'OR ISNULL([Target].[' + @ColumnName + N'],' + @NullableReplacementValue + N') <> ISNULL(source.[' + @ColumnName + N'],' + @NullableReplacementValue + N')'
							);
						END

			IF(@AttributeType = N'CV')
				BEGIN
					SET @InsertModelEntityMembersStatement = REPLACE(@InsertModelEntityMembersStatement,
						N'#Type1ColumnUpdate#',
						(CASE WHEN (@AttributeTypeIndex > 1) THEN N'#Type1ColumnUpdate#' + CHAR(10) + REPLICATE(CHAR(9),3) ELSE N'' END) + 
						N',[' + @ColumnName + N'] = source.[' + @ColumnName + N']'
					);
				END

			FETCH NEXT FROM C_COLUMN_LIST INTO @ColumnName, @ColumnOrdinal, @AttributeType, @AttributeTypeIndex, @IsPrimaryKey;
		END
	CLOSE C_COLUMN_LIST;
	DEALLOCATE C_COLUMN_LIST;

	--remove unused tokens
	EXEC [Controller].[UtilRemoveTokens] @InsertModelEntityMembersStatement OUTPUT;

	IF (@DebugOnly = 1)
		PRINT @InsertModelEntityMembersStatement;
	ELSE
		-- merge transformed data with model table
		DECLARE @ErrorNumber int = 0;

		EXEC(@InsertModelEntityMembersStatement);
		SET @ErrorNumber = @@ERROR;

		-- if the merege is successful, empty the changed keys table (if it is change tracked) so that the changes are not included in the next transform
		IF (OBJECT_ID(@FQModelEntityChangedKeysTableName) IS NOT NULL)
		AND(@ErrorNumber = 0)
		BEGIN
			DECLARE @FlushChangedKeysTableStatement nvarchar(512) = N'TRUNCATE TABLE ' + @FQModelEntityChangedKeysTableName;
			EXEC(@FlushChangedKeysTableStatement);
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
	WHERE ([Audit].[ModelTable] = ' + ''''  +  @ModelEntityType + @ModelEntityName  + '''' + ')
	AND ([Audit].[ExecutionID] = ' + CONVERT(NVARCHAR(30),@ExecutionID )  + ')'

	
	EXEC(@UpdateAuditTable);


	SET @InsertAuditTable = 
	N'UPDATE [Audit]
	SET [InsertCount] = ISNULL([Temp].[InsertCount],0),
	[EndTime] = GETDATE()
	FROM [Audit].[ModelExecutionStats] [Audit]
	LEFT JOIN (SELECT ExecutionID, COUNT(*) AS ''InsertCount'' FROM ' + @TempTableName + ' WHERE [ChangeType] = ''Insert'' GROUP BY ExecutionID) Temp
	ON ([Audit].[ExecutionID] = [Temp].[ExecutionID])
	WHERE ([Audit].[ModelTable] = ' + '''' +  @ModelEntityType + @ModelEntityName  + '''' + ')
	AND ([Audit].[ExecutionID] = ' + CONVERT(NVARCHAR(30),@ExecutionID )  + ')'

	EXEC(@InsertAuditTable);

