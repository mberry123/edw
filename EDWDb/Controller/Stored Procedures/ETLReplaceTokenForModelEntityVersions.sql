
CREATE PROCEDURE [Controller].[ETLReplaceTokenForModelEntityVersions](
	@DMLStatement nvarchar(max) OUTPUT,
	@Token nvarchar(128),
	@ColumnName sysname,
	@TableAlias nvarchar(384),
	@ModelEntityTableName sysname,
	@ModelEntityTableAlias sysname,
	@ReinsertToken bit = 0,
    @ModelParentEntityTableName sysname,
	@ModelEntityTablePK sysname
)
AS
BEGIN
	DECLARE @WorkingDMLStatement nvarchar(max) = @DMLStatement;
	DECLARE @DimensionCurrencyName VARCHAR(120);
	

	SELECT @DimensionCurrencyName = 
			[ColumnName]
		FROM [Controller].[fnModelColumns](@ModelParentEntityTableName)
		WHERE  (ISNULL([IsMetaData],0) = 0)
		AND [FactType] = 'DC';

	DECLARE C_BK_COLUMNS CURSOR FOR (
		SELECT
			[ColumnName],
			[KeyTypeIndex]
		FROM [Controller].[fnModelColumns](@ModelEntityTableName)
		WHERE  (ISNULL([KeyType],N'') LIKE '%BK%')
	 UNION ALL 
	     SELECT '',11 --
	) ORDER BY [KeyTypeIndex] DESC;
	OPEN C_BK_COLUMNS;

	DECLARE @BKColumnName sysname, @BKTypeIndex int;
	FETCH NEXT FROM C_BK_COLUMNS INTO @BKColumnName, @BKTypeIndex;
	WHILE(@@FETCH_STATUS = 0)
		BEGIN
			SET @WorkingDMLStatement = REPLACE(@WorkingDMLStatement ,
				@Token,
				(CASE
					WHEN  (@ReinsertToken = 1)
						OR(@BKTypeIndex > 1) --ModelEntity has composite business key
					THEN @Token + CHAR(10) + REPLICATE(CHAR(9),1)
					ELSE ''
				END) +
				(CASE WHEN @BKTypeIndex < 10
				THEN
				(CASE
					WHEN (@BKTypeIndex > 1) THEN
						REPLICATE(CHAR(9),1) + N'AND '
					ELSE
					    N'OUTER APPLY (' + CHAR(10) + REPLICATE(CHAR(9),1) +
					    N'SELECT TOP 1 ' + @ModelEntityTablePK + CHAR(10) + REPLICATE(CHAR(9),1) +
					    N'FROM [Transform].[fn' + @ModelEntityTableName + N'Versions]()' + CHAR(10) + REPLICATE(CHAR(9),1) +
						N'WHERE ' + CHAR(10) + REPLICATE(CHAR(9),1) +
						N'(' + CHAR(10) + REPLICATE(CHAR(9),1) +
						N'(' + CHAR(10) + REPLICATE(CHAR(9),1) +
						N'-- Only one member' + CHAR(10) + REPLICATE(CHAR(9),1) +
						N'([EndDate] IS NULL)' + CHAR(10) + REPLICATE(CHAR(9),1) +
						N'AND ([Version] = 1)' + CHAR(10) + REPLICATE(CHAR(9),1) +
						N')' + CHAR(10) + REPLICATE(CHAR(9),1) +
						N'OR (' + CHAR(10) + REPLICATE(CHAR(9),1) +
						N'-- Before first member' + CHAR(10) + REPLICATE(CHAR(9),1) +
						N'([StartDate] >= ' + @TableAlias + N'.' +  @DimensionCurrencyName + N')'  + CHAR(10) + REPLICATE(CHAR(9),1) +
						N'AND ([Version] = 1)' + CHAR(10) + REPLICATE(CHAR(9),1) +
						N')' + CHAR(10) + REPLICATE(CHAR(9),1) +
						N'OR (' + CHAR(10) + REPLICATE(CHAR(9),1) +
						N'-- Newer version member' + CHAR(10) + REPLICATE(CHAR(9),1) +
						N'[StartDate] < ' + @TableAlias + N'.' +  @DimensionCurrencyName + N')'  + CHAR(10) + REPLICATE(CHAR(9),1) +
						N'AND (ISNULL([EndDate],' +  @TableAlias + N'.' +  @DimensionCurrencyName + N') >= ' +  @TableAlias + N'.' +  @DimensionCurrencyName  + CHAR(10) + REPLICATE(CHAR(9),1) +
						N')' + CHAR(10) + REPLICATE(CHAR(9),1) +
						N'OR (' + CHAR(10) + REPLICATE(CHAR(9),1) +
						N'-- New version member same day' + CHAR(10) + REPLICATE(CHAR(9),1) +
						N'CONVERT(DATE,[StartDate]) = ' + @TableAlias + N'.' +  @DimensionCurrencyName + N')'  + CHAR(10) + REPLICATE(CHAR(9),1) +
						N'AND ([EndDate] IS NULL)' + CHAR(10) + REPLICATE(CHAR(9),1) +
						N')' + CHAR(10) + REPLICATE(CHAR(9),1) +
		                N'AND ' 
				END )
				+  N'([' + @BKColumnName + N'] = ' + @TableAlias + N'.[' + @ColumnName + N'_' + @BKColumnName + N'])'
				
			    ELSE N' ORDER BY ' + @ModelEntityTablePK + N' DESC ) ' + @ModelEntityTableAlias
			END)						) 	

			FETCH NEXT FROM C_BK_COLUMNS INTO @BKColumnName, @BKTypeIndex;
		END
	CLOSE C_BK_COLUMNS;
	DEALLOCATE C_BK_COLUMNS;

	SET @DMLStatement = @WorkingDMLStatement 

	RETURN(0);
END
