
CREATE PROCEDURE [Controller].[ETLReplaceTokenJoinCondition](
	@DMLStatement nvarchar(max) OUTPUT,
	@Token nvarchar(128),
	@ColumnName sysname,
	@TableAlias sysname,
	@ReferencedColumnName sysname,
	@ReferencedTableAlias sysname,
	@ReinsertToken bit = 0
)
AS
BEGIN
	SET @DMLStatement = REPLACE(@DMLStatement,
		@Token,
		(CASE
			WHEN (@ReinsertToken = 1) THEN @Token + CHAR(10) + REPLICATE(CHAR(9),1) + N'AND'
			ELSE N'ON '
		END) + 
		N'(' + @TableAlias + N'.[' + @ColumnName + N'] = ' + @ReferencedTableAlias + '.[' + @ReferencedColumnName + N'])'
	);

	RETURN(0);
END
