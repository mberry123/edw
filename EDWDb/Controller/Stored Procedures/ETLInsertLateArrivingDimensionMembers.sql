
CREATE PROCEDURE [Controller].[ETLInsertLateArrivingDimensionMembers](
	@ModelName nvarchar(124),
	@ExecutionID bigint,
	@DebugOnly bit = 0
)
AS
BEGIN
	--AUDIT START

	IF NOT EXISTS (SELECT * FROM [Audit].[ModelExecutionStats] WHERE ExecutionID = @ExecutionId AND [ModelTable] = N'Fact' + @ModelName)
	BEGIN
	  INSERT INTO [Audit].[ModelExecutionStats] ([ExecutionID],[ModelTable],[ChangedKeyCount],[StartTime])
	  SELECT TOP 1 @ExecutionId
			 ,N'Fact' + @ModelName
			 ,[ChangedKeys].[ChangedKeysCount]
			 ,GETDATE()
	  FROM [Audit].[ExecutionChangedKeyCounts] [ChangedKeys]
	  WHERE [ChangedKeys].[ExecutionID] = @ExecutionId
	  AND [ChangedKeys].[ChangedKeysTable] = N'Fact' + @ModelName + N'ChangedKeys'
	END;
	--AUDIT END
	IF (@DebugOnly = 1)
		PRINT N'@ModelName: ' + ISNULL(@ModelName,N'NULL');
	ELSE
		BEGIN
			IF(@ModelName IS NULL)
				BEGIN
					RAISERROR(50001,16,1,N'@ModelName');
					RETURN;
				END
		END

	DECLARE @FactTableName sysname = N'Fact' + @ModelName;
	DECLARE @FQFactTableName nvarchar(256) = N'[Model].[' + @FactTableName + N']';
	DECLARE @FQFactChangesView nvarchar(256) = N'[Transform].[' + @FactTableName + N'ChangesView]';
	
	-- Persist the transform view for performance optimisation
	DECLARE @FQFactChangesViewPersisted nvarchar(256) = N'[Transform].[' + @FactTableName + N'ChangesViewPersistedForLAD]';
	EXEC [Controller].[ETLPersistTransformViewForLAD] @ModelName, @DebugOnly;

	DECLARE C_FK_TABLES CURSOR FOR (
		SELECT
			[ReferencedTableName],
			(
				SELECT
					[TableLoadOrder]
				FROM [Controller].[fnModelTables]([ReferencedTableName])
			) AS 'ReferencedTableLoadOrder',
			[ColumnName]
		FROM  [Controller].[fnModelColumns](@FactTableName)
		WHERE  ([IsForeignKey] = 1)
			AND([ReferencedTableName] <> 'DimDate')
			AND([ReferencedTableName] <> 'DimTime')
	)
	ORDER BY -- order to avoid deadlocks
		[ReferencedTableLoadOrder] ASC,
		[ReferencedTableName] ASC;

	OPEN C_FK_TABLES;

	DECLARE @ReferencedTableName sysname, @ReferencedTableLoadOrder int, @ForeignKeyColumn sysname;
	FETCH NEXT FROM C_FK_TABLES INTO @ReferencedTableName, @ReferencedTableLoadOrder, @ForeignKeyColumn;
	WHILE(@@FETCH_STATUS = 0)
		BEGIN
			IF (@DebugOnly = 1)
				PRINT @ReferencedTableName

			-- isolation level is needed to prevent PK violation caused by mulitple facts loading in parallel
			DECLARE @InsertLateArrivingMemberStatement nvarchar(max) = N'
			INSERT INTO [Model].[' + @ReferencedTableName + N'](
				[ExecutionID]
				,[SCDBitmap]
				,[StartDate]
				,[IsLateArrivingMember]
				#BusinessKeyColumn#
			)
			SELECT
				' + CAST(@ExecutionID AS nvarchar) + '
				,0
				,GETDATE()
				,1
				#BusinessKeyRef#
			FROM ' + @FQFactChangesViewPersisted + N' AS fact
			LEFT JOIN [Model].[' + @ReferencedTableName + N'] AS dim
				#BusinessKeyJoinCondition#
				AND(dim.[EndDate] IS NULL)
			WHERE (dim.[StartDate] IS NULL)
				#BusinessKeyFilter#
			GROUP BY
				#GroupByRef#
			';

			DECLARE C_COLUMN_LIST CURSOR FOR (
				SELECT
					[ColumnName], 
					[ColumnOrdinal],
					[KeyType],
					[KeyTypeIndex]
				FROM [Controller].[fnModelColumns](@ReferencedTableName)
				WHERE (ISNULL(CHARINDEX(N'BK',[KeyType],1),0) > 0)
			) ORDER BY [ColumnOrdinal] DESC;

			OPEN C_COLUMN_LIST;
			DECLARE @ColumnName sysname, @ColumnOrdinal int, @KeyType nvarchar(16), @KeyTypeIndex int;
			FETCH NEXT FROM C_COLUMN_LIST INTO @ColumnName, @ColumnOrdinal, @KeyType, @KeyTypeIndex;
			WHILE(@@FETCH_STATUS = 0)
				BEGIN
					SET @InsertLateArrivingMemberStatement = REPLACE(@InsertLateArrivingMemberStatement,
						N'#BusinessKeyColumn#',
						(CASE WHEN (@KeyTypeIndex > 1) THEN N'#BusinessKeyColumn#' + CHAR(10) + REPLICATE(CHAR(9),4) ELSE N'' END) + 
						N',[' + @ColumnName + N']'
					);

					SET @InsertLateArrivingMemberStatement = REPLACE(@InsertLateArrivingMemberStatement,
						N'#BusinessKeyRef#',
						(CASE WHEN (@KeyTypeIndex > 1) THEN N'#BusinessKeyRef#' + CHAR(10) + REPLICATE(CHAR(9),4) ELSE N'' END) + 
						N',fact.[' + @ForeignKeyColumn + N'_' + @ColumnName + N']'
					);

					SET @InsertLateArrivingMemberStatement = REPLACE(@InsertLateArrivingMemberStatement,
						N'#BusinessKeyJoinCondition#',
						(CASE WHEN (@KeyTypeIndex > 1) THEN N'#BusinessKeyJoinCondition#' + CHAR(10) + REPLICATE(CHAR(9),4) + N'AND' ELSE N'ON ' END) + 
						N'(dim.[' + @ColumnName + N'] = fact.[' + @ForeignKeyColumn + N'_' + @ColumnName + N'])'
					);

					SET @InsertLateArrivingMemberStatement = REPLACE(@InsertLateArrivingMemberStatement,
						N'#BusinessKeyFilter#',
						(CASE WHEN (@KeyTypeIndex > 1) THEN N'#BusinessKeyFilter#' ELSE N'--exclude non-related facts' END) + CHAR(10) + REPLICATE(CHAR(9),4) +
						N'AND (fact.[' + @ForeignKeyColumn + N'_' + @ColumnName + N'] IS NOT NULL)'
					);

					SET @InsertLateArrivingMemberStatement = REPLACE(@InsertLateArrivingMemberStatement,
						N'#GroupByRef#',
						(CASE WHEN (@KeyTypeIndex > 1) THEN N'#GroupByRef#' + CHAR(10) + REPLICATE(CHAR(9),4) + N',' ELSE N'' END) + 
						N'fact.[' + @ForeignKeyColumn + N'_' + @ColumnName + N']'
					);

					FETCH NEXT FROM C_COLUMN_LIST INTO @ColumnName, @ColumnOrdinal, @KeyType, @KeyTypeIndex;
				END
			CLOSE C_COLUMN_LIST;
			DEALLOCATE C_COLUMN_LIST;

			IF (@DebugOnly = 1)
				PRINT @InsertLateArrivingMemberStatement;
			ELSE
				EXEC(@InsertLateArrivingMemberStatement);

			FETCH NEXT FROM C_FK_TABLES INTO @ReferencedTableName, @ReferencedTableLoadOrder, @ForeignKeyColumn;
		END
	CLOSE C_FK_TABLES;
	DEALLOCATE C_FK_TABLES;

	RETURN(0);
END
