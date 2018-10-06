
CREATE FUNCTION [Controller].[fnGetConfigurationItem](
	@KeyName nvarchar(128)
)
	RETURNS nvarchar(256)
AS
BEGIN
	DECLARE @ReturnValue nvarchar(256) = N'';

	SELECT
		@ReturnValue = [KeyValue]
	FROM [Controller].[Configuration]
	WHERE ([KeyName] = @KeyName);

	RETURN @ReturnValue;
END
