
CREATE PROCEDURE [Controller].[ETLReplaceTokenForSCDColumnModelEntityValue](
	@DMLStatement nvarchar(max) OUTPUT,
	@Token nvarchar(128),
	@TargetColumnName sysname,
	@SourceColumnName sysname,
	@ChangesTableAlias sysname,
	@ExistingTableAlias sysname,
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
		N'(CASE
			WHEN (' + @ExistingTableAlias + N'.[IsLateArrivingMember] = 1) THEN ' + 
				(CASE
					WHEN (@IsModelEntityKey = 1) THEN N'ISNULL(' + @ChangesTableAlias + N'.[' + @SourceColumnName + N'],-1)'
					ELSE @ChangesTableAlias + N'.[' + @SourceColumnName + N']'
				END) +
			N'ELSE ' + @ExistingTableAlias + N'.[' + @TargetColumnName + N'] 
		END)'
	);

	RETURN(0);
END
