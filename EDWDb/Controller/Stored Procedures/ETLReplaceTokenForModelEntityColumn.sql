
CREATE PROCEDURE [Controller].[ETLReplaceTokenForModelEntityColumn](
	@DMLStatement nvarchar(max) OUTPUT,
	@Token nvarchar(128),
	@TableAlias sysname = NULL,
	@ColumnName sysname,
	@ColumnAlias sysname = NULL,
	@ReinsertToken bit = 0,
	@AppendToList bit = 0,
	@IsModelEntityKey bit = 0
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
		(CASE
			WHEN (@IsModelEntityKey = 1) THEN N'ISNULL(' + ISNULL(@TableAlias + N'.',N'') + N'[' + @ColumnName + N'],-1)' + ISNULL(N' AS ''' + @ColumnAlias + N'''',N'')
			ELSE ISNULL(@TableAlias + N'.',N'') + N'[' + @ColumnName + N']' + ISNULL(N' AS ''' + @ColumnAlias + N'''',N'')
		END)
	);

	RETURN(0);
END
