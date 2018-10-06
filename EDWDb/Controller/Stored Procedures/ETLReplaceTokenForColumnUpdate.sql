
CREATE PROCEDURE [Controller].[ETLReplaceTokenForColumnUpdate](
	@DMLStatement nvarchar(max) OUTPUT,
	@Token nvarchar(128),
	@TargetColumnName sysname,
	@SourceTableAlias sysname,
	@SourceColumnName sysname,
	@ReinsertToken bit = 0,
	@AppendToList bit = 0,
	@IsDimensionKey bit = 0
)
AS
BEGIN
	SET @DMLStatement = REPLACE(@DMLStatement,
		@Token,
		(CASE
			WHEN (@ReinsertToken = 0) THEN N''
			ELSE @Token + CHAR(10) + REPLICATE(CHAR(9),1)
		END) + 
		(CASE
			WHEN @AppendToList = 1 THEN N','
			ELSE N''
		END) +
		N'[' + @TargetColumnName + N'] = ' + 
		(CASE
			WHEN (@IsDimensionKey = 1) THEN N'ISNULL(' + @SourceTableAlias + N'.[' + @SourceColumnName + N']' + N',-1)'
			ELSE @SourceTableAlias + N'.[' + @SourceColumnName + N']'
		END)
	);

	RETURN(0);
END
