
CREATE FUNCTION [Controller].[GetErrorXml]()
	RETURNS xml
AS
BEGIN
	DECLARE @ExceptionXml xml = N'<Exception>
		<ErrorNumber>' + CAST(ERROR_NUMBER() AS nvarchar) + N'</ErrorNumber>
		<ErrorProcedure>' + ISNULL(ERROR_PROCEDURE(),'') + N'</ErrorProcedure>
		<ErrorLine>' + CAST(ERROR_LINE() AS nvarchar) + N'</ErrorLine>
		<ErrorMessage>' + ERROR_MESSAGE() + N'</ErrorMessage>
	</Exception>';

	RETURN @ExceptionXml;
END;
