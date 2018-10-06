
CREATE PROCEDURE [Controller].[UtilPersistView](
	@FQViewName nvarchar(256),
	@FQPersistedTableName nvarchar(256) OUTPUT,
	@DebugOnly bit = 0
)
AS
BEGIN
	SELECT
		@FQPersistedTableName = N'[' + SCHEMA_NAME(vwobj.[schema_id]) + N'].[' + vwobj.[name] + N'Persisted]'
	FROM sys.views AS vwobj
	WHERE (vwobj.[object_id] = OBJECT_ID(@FQViewName));
	
	IF OBJECT_ID(@FQPersistedTableName) IS NOT NULL
		BEGIN
			DECLARE @DropTableStatement nvarchar(512) = N'DROP TABLE ' + @FQPersistedTableName;
			IF(@DebugOnly = 1)
				PRINT @DropTableStatement;
			ELSE
				EXEC(@DropTableStatement);
		END

	DECLARE @CreateTableStatement nvarchar(max) = 
N'SELECT
	#ColumnName#
INTO ' + @FQPersistedTableName + '
FROM ' + @FQViewName;

	DECLARE C_VW_COLUMNS CURSOR FOR (
		SELECT
			N'CAST([' + cols.[COLUMN_NAME] + N'] AS ' + 
			(CASE
				WHEN cols.[CHARACTER_MAXIMUM_LENGTH] IS NULL
					THEN cols.[DATA_TYPE] +
						(CASE
							WHEN (cols.[DATA_TYPE] IN ('NUMERIC','DECIMAL'))
							THEN
								ISNULL(N'('+ CAST(cols.[NUMERIC_PRECISION] AS nvarchar) + 
								ISNULL(N',' + CAST(cols.[NUMERIC_SCALE] AS nvarchar),N'') + N')',N'')
							ELSE N''
						END)
				ELSE cols.[DATA_TYPE] + '(' + 
					(CASE
						WHEN (cols.[CHARACTER_MAXIMUM_LENGTH] = -1)
						THEN 'max'
						ELSE CAST(cols.[CHARACTER_MAXIMUM_LENGTH] AS varchar)
					END) + ')'
			END) + ') AS ''' + cols.[COLUMN_NAME] + N'''',
			ROW_NUMBER() OVER(ORDER BY cols.[ORDINAL_POSITION] DESC) AS 'Order'
		FROM INFORMATION_SCHEMA.COLUMNS AS cols
		WHERE ( '[' + cols.[TABLE_SCHEMA] + '].[' + cols.[TABLE_NAME] + ']' = @FQViewName)
	)
	ORDER BY [Order] DESC
	OPEN C_VW_COLUMNS;

	DECLARE @ColumnName sysname, @Position int;
	FETCH NEXT FROM C_VW_COLUMNS INTO @ColumnName, @Position;
	WHILE(@@FETCH_STATUS = 0)
		BEGIN
			SET @CreateTableStatement = REPLACE(@CreateTableStatement,
				N'#ColumnName#',
				@ColumnName + 
				(CASE
					WHEN (@Position = 1)
					THEN N''
					ELSE CHAR(10) + REPLICATE(CHAR(9),1) + N',#ColumnName#'
				END)
			);

			FETCH NEXT FROM C_VW_COLUMNS INTO @ColumnName, @Position;
		END
	CLOSE C_VW_COLUMNS;
	DEALLOCATE C_VW_COLUMNS;

	IF(@DebugOnly = 1)
		SELECT @CreateTableStatement;
	ELSE
		EXEC(@CreateTableStatement);

	RETURN(0);
END
