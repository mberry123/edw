
/*<Comment>
This function is used for both Dimension tables and time stamped Fact tables because they will always use a single surrogate key.
Other Fact tables may have composite keys.
</Comment>*/
CREATE FUNCTION [Controller].[fnModelEntityPrimaryKey](
	@ModelEntityTableName sysname
) RETURNS sysname
AS
BEGIN
	DECLARE @PrimaryKeyColumnName sysname;

	SELECT
		@PrimaryKeyColumnName = [ColumnName]
	FROM [Controller].[fnModelColumns](@ModelEntityTableName)
	WHERE ([IsPrimaryKey] = 1);

	RETURN @PrimaryKeyColumnName;
END
