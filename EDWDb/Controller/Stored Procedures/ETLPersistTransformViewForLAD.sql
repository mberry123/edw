
CREATE PROCEDURE [Controller].[ETLPersistTransformViewForLAD](
	@ModelName nvarchar(124),
	@DebugOnly bit = 0
)
AS
BEGIN
	DECLARE @RC int = 0;
	DECLARE @FactTableName sysname = N'Fact' + @ModelName;
	DECLARE @FQFactTableName nvarchar(256) = N'[Model].[' + @FactTableName + N']';
	DECLARE @FQFactChangesView nvarchar(256) = N'[Transform].[' + @FactTableName + N'ChangesView]';
	DECLARE @FQFactChangesViewPersisted nvarchar(256) = N'[Transform].[' + @FactTableName + N'ChangesViewPersistedForLAD]';

	IF (@DebugOnly = 1)
		PRINT N'@FQFactChangesViewPersisted: ' + ISNULL(@FQFactChangesViewPersisted,N'NULL');

	-- Persist the changes view (performance optimisation only)
	IF OBJECT_ID(@FQFactChangesViewPersisted) IS NOT NULL
		BEGIN
			DECLARE @DropPersistedTableStatement nvarchar(max) = N'DROP TABLE ' + @FQFactChangesViewPersisted;

			IF (@DebugOnly = 1)
				PRINT @DropPersistedTableStatement;
			ELSE
				EXEC(@DropPersistedTableStatement);
		END
	DECLARE @CreatePersistedTableStatement nvarchar(max) = N'
--Persisting ' + @FQFactChangesView + ' view
SELECT
	#BusinessKeyColumnName#
INTO ' + @FQFactChangesViewPersisted + '
FROM ' + @FQFactChangesView;

	DECLARE C_FK_COLUMNS CURSOR FOR (
		SELECT
			N'CAST([' + fact.[ColumnName] + N'_' + dim.[ColumnName] + N'] AS ' + 
			(CASE
				WHEN cols.[CHARACTER_MAXIMUM_LENGTH] IS NULL THEN cols.[DATA_TYPE]
				ELSE cols.[DATA_TYPE] + '(' + CAST(cols.[CHARACTER_MAXIMUM_LENGTH] AS varchar) + ')'
			END) + ') AS ''' + fact.[ColumnName] + N'_' + dim.[ColumnName] + N'''' AS 'BusinessKeyColumnName'
		FROM  [Controller].[fnModelColumns](@FactTableName) AS fact
		CROSS APPLY [Controller].[fnModelColumns](fact.[ReferencedTableName]) AS dim
		LEFT JOIN INFORMATION_SCHEMA.COLUMNS AS cols
			ON (cols.[TABLE_SCHEMA] = N'Model')
			AND(cols.[TABLE_NAME] = fact.[ReferencedTableName])
			AND(cols.[COLUMN_NAME] = dim.[ColumnName])
		WHERE  (fact.[IsForeignKey] = 1)
			AND(fact.[ReferencedTableName] <> 'DimDate')
			AND(fact.[ReferencedTableName] <> 'DimTime')
			AND(ISNULL(CHARINDEX(N'BK',dim.[KeyType],1),0) > 0)
	)
	OPEN C_FK_COLUMNS;

	DECLARE @BusinessKeyColumnName nvarchar(256)
		,@FKCount int = 0;
	FETCH NEXT FROM C_FK_COLUMNS INTO @BusinessKeyColumnName;
	WHILE(@@FETCH_STATUS = 0)
		BEGIN
			SET @CreatePersistedTableStatement = REPLACE(@CreatePersistedTableStatement,
				N'#BusinessKeyColumnName#',
				@BusinessKeyColumnName + CHAR(10) + REPLICATE(CHAR(9),1) +
				N',#BusinessKeyColumnName#' 
			);
			SET @FKCount += 1;
			FETCH NEXT FROM C_FK_COLUMNS INTO @BusinessKeyColumnName;
		END
	CLOSE C_FK_COLUMNS;
	DEALLOCATE C_FK_COLUMNS;

	-- check that there are actually foreign keys (there should be!)
	IF (@FKCount = 0)
		BEGIN
			SET @RC = 50001;
			THROW @RC, 'There are no foreign keys defined on the table. Fact tables must have foreign keys defined for all related dimensions.', 1;
			RETURN(@RC);
		END

	--Remove tokens from statements
	SET @CreatePersistedTableStatement =
		REPLACE(
			@CreatePersistedTableStatement,
			N',#BusinessKeyColumnName#',
			N''
		);

	IF (@DebugOnly = 1)
		BEGIN
			PRINT @CreatePersistedTableStatement;
		END
	ELSE
		BEGIN
			EXEC(@CreatePersistedTableStatement);
		END

	RETURN(@RC);
END
