
CREATE PROCEDURE [Controller].[UtilRemoveTokens](
	@SQLStatment nvarchar(max) OUTPUT
)
AS
BEGIN
	SET @SQLStatment = REPLACE(@SQLStatment,N'#', N'--');

	RETURN(0);
END
