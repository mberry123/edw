
CREATE PROCEDURE [Controller].[ETLReplaceTokenForSCDColumn](
	@DMLStatement nvarchar(max) OUTPUT,
	@Token nvarchar(128),
	@ColumnName sysname,
	@ChangesTableAlias sysname,
	@ExistingTableAlias sysname,
	@ReinsertToken bit = 0,
	@AppendToList bit = 0
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
		N'(CASE
			WHEN (' + @ExistingTableAlias + N'.[IsLateArrivingMember] = 1) THEN ' + @ChangesTableAlias + N'.[' + @ColumnName + N']
			ELSE ' + @ExistingTableAlias + N'.[' + @ColumnName + N'] 
		END)'
	);

	RETURN(0);
END
