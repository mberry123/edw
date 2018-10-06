
CREATE FUNCTION [Transform].[fnGetCharTimeFromSeconds]
(@Seconds INT)
RETURNS CHAR (8)
AS
BEGIN
	DECLARE @ReturnValue CHAR(8);
	
	IF (@Seconds > 86400)--seconds in a 24hr day
		RETURN(@ReturnValue);
	
	SET @ReturnValue = 
		RIGHT('0' + CAST(@Seconds/3600 AS VARCHAR(2)),2)
		+ ':' 
		+ RIGHT('0' + CAST((@Seconds - (@Seconds/3600 * 3600))/60 AS VARCHAR(2)),2)
		+ ':'
		+ RIGHT('0' + CAST(+  @Seconds % 60 AS VARCHAR(2)),2);

	RETURN(@ReturnValue);
END
