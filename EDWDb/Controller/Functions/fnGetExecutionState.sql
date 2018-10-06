
CREATE FUNCTION [Controller].[fnGetExecutionState](
	@PropertyID VARCHAR(64)
)
RETURNS VARCHAR(256)
AS
BEGIN
	DECLARE @PropertyValue VARCHAR(256);

	SELECT @PropertyValue = [PropertyValue]
	FROM [Controller].[ExecutionState]
	WHERE ([PropertyID] = @PropertyID);

	RETURN @PropertyValue;
END
