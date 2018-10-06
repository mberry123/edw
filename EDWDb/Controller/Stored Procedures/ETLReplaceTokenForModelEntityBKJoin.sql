
CREATE PROCEDURE [Controller].[ETLReplaceTokenForModelEntityBKJoin](
	@DMLStatement nvarchar(max) OUTPUT,
	@Token nvarchar(128),
	@ColumnName sysname,
	@TableAlias nvarchar(384),
	@ModelEntityTableName sysname,
	@ModelEntityTableAlias sysname,
	@ReinsertToken bit = 0
)
AS
BEGIN
	DECLARE @WorkingDMLStatement nvarchar(max) = @DMLStatement;

	DECLARE C_BK_COLUMNS CURSOR FOR (
		SELECT
			[ColumnName],
			[KeyTypeIndex]
		FROM [Controller].[fnModelColumns](@ModelEntityTableName)
		WHERE  (ISNULL([KeyType],N'') LIKE '%BK%')
	) ORDER BY [KeyTypeIndex] DESC;
	OPEN C_BK_COLUMNS;

	DECLARE @BKColumnName sysname, @BKTypeIndex int;
	FETCH NEXT FROM C_BK_COLUMNS INTO @BKColumnName, @BKTypeIndex;
	WHILE(@@FETCH_STATUS = 0)
		BEGIN
			SET @WorkingDMLStatement = REPLACE(@WorkingDMLStatement,
				@Token,
				(CASE
					WHEN  (@ReinsertToken = 1)
						OR(@BKTypeIndex > 1) --ModelEntity has composite business key
					THEN @Token + CHAR(10) + REPLICATE(CHAR(9),1)
					ELSE N''
				END) +
				(CASE
					WHEN (@BKTypeIndex > 1) THEN
						REPLICATE(CHAR(9),1) + N'AND'
					ELSE
						N'LEFT JOIN [Model].[' + @ModelEntityTableName + N'] AS ' + @ModelEntityTableAlias + CHAR(10) + REPLICATE(CHAR(9),1) + 
						N'ON (' + @ModelEntityTableAlias + N'.[EndDate] IS NULL)' + CHAR(10) + REPLICATE(CHAR(9),1) + N'AND'
				END) + 
				N'(' + @ModelEntityTableAlias + N'.[' + @BKColumnName + N'] = ' + @TableAlias + N'.[' + @ColumnName + N'_' + @BKColumnName + N'])'
			);

			FETCH NEXT FROM C_BK_COLUMNS INTO @BKColumnName, @BKTypeIndex;
		END
	CLOSE C_BK_COLUMNS;
	DEALLOCATE C_BK_COLUMNS;

	SET @DMLStatement = @WorkingDMLStatement;

	RETURN(0);
END
