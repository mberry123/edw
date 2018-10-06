
CREATE FUNCTION [Transform].[fnGetTimeFromInteger](
	@IntegerTime integer
) RETURNS time
AS
BEGIN
	DECLARE @ReturnValue time;

	DECLARE @IntegerTimeString char(6);
	SET @IntegerTimeString = RIGHT('000000' + CAST(@IntegerTime AS varchar(6)),6);

	SET @ReturnValue = 
		LEFT(@IntegerTimeString,2)
		+ ':' + SUBSTRING(@IntegerTimeString,3,2)
		+ ':' + RIGHT(@IntegerTimeString,2);

	RETURN @ReturnValue;
END
