
CREATE PROCEDURE [Controller].[ETLReplaceTokenForModelEntityPKJoin](
	@DMLStatement nvarchar(max) OUTPUT,
	@Token nvarchar(128),
	@ColumnName sysname,
	@TableAlias sysname,
	@ReferencedColumnName sysname,
	@ReferencedTableName sysname,
	@ReferencedTableAlias sysname,
	@ReinsertToken bit = 0
)
AS
BEGIN

	SET @DMLStatement = REPLACE(@DMLStatement,
		@Token,
		(CASE
			WHEN (@ReinsertToken = 1) THEN @Token + CHAR(10) + REPLICATE(CHAR(9),1)
			ELSE N''
		END) +
		N'INNER JOIN [Model].[' + @ReferencedTableName + N'] AS ' + @ReferencedTableAlias + CHAR(10) + REPLICATE(CHAR(9),1) + N'ON ' +
		N'(' + @ReferencedTableAlias + N'.[' + @ReferencedColumnName + N'] = ' + @TableAlias + N'.[' + @ColumnName + N'])'
	);

RETURN 0
END
