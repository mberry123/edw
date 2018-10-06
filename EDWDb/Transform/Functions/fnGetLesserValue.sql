
CREATE FUNCTION [Transform].[fnGetLesserValue](
	@Value1 numeric(18,2),
	@Value2 numeric(18,2)
) RETURNS numeric(18,2)
AS
BEGIN
	DECLARE @ReturnValue numeric(18,2) =
		(CASE
			WHEN (@Value1 < @Value2)
			THEN @Value1
			ELSE @Value2
		END);

	RETURN @ReturnValue;
END
