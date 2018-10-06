
CREATE PROCEDURE [Controller].[ETLReplaceTokenSCDBitmap](
	@DMLStatement nvarchar(max) OUTPUT,
	@Token nvarchar(128),
	@ColumnName sysname,
	@ColumnBit int,
	@IsForeignKey bit,
	@ChangesTableAlias sysname,
	@ChangesColumnName sysname,
	@ExistingTableAlias sysname,
	@ReinsertToken bit = 0
)
AS
BEGIN
	SET @DMLStatement = REPLACE(@DMLStatement,
		@Token,
		(CASE
			WHEN (@ReinsertToken = 0) THEN N''
			ELSE @Token + CHAR(10) + REPLICATE(CHAR(9),1)
		END) + 
		N'+ (CASE
			WHEN (COALESCE(' + @ChangesTableAlias + N'.[' + @ChangesColumnName + N'],' + @ExistingTableAlias + N'.[' + @ColumnName + N'],NULL) IS NULL) THEN 0
			WHEN (COALESCE(' + @ChangesTableAlias + N'.[' + @ChangesColumnName + N'],' + @ExistingTableAlias + N'.[' + @ColumnName + N'],NULL) IS NOT NULL) THEN
				(CASE
					WHEN (' + 
						(CASE
							WHEN (@IsForeignKey = 1) THEN
								'ISNULL(' + @ChangesTableAlias + N'.[' + @ChangesColumnName + N'],-1)'
							ELSE
								@ChangesTableAlias + N'.[' + @ChangesColumnName + N']'
						END) + ' = ' + @ExistingTableAlias + N'.[' + @ColumnName + N']) THEN 0
					ELSE ' + CAST(@ColumnBit AS nvarchar) + '
				END)
			ELSE 0 
		END)'
	);

	RETURN(0);
END
