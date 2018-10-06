
/*Capitalises words within input string*/
CREATE FUNCTION [Transform].[fnConvertToCapitals](
	@InputString varchar(2000)
)
	RETURNS VARCHAR(2000)
AS
BEGIN
	DECLARE @Index INT;
	DECLARE @Char CHAR(1);
	DECLARE @PrevChar CHAR(1);
	DECLARE @OutputString VARCHAR(2000);

	SET @OutputString = LOWER(rtrim(ltrim(@InputString)));
	SET @Index = 1;

	WHILE (@Index <= LEN(@InputString))
		BEGIN
			SET @Char = SUBSTRING(@InputString, @Index, 1);
			SET @PrevChar =
				(CASE
					WHEN (@Index = 1)
					THEN ' '
					ELSE SUBSTRING(@InputString, @Index - 1, 1)
				END);

		IF (@PrevChar =' ')
			BEGIN
				SET @OutputString = STUFF(@OutputString, @Index, 1, UPPER(@Char));
			END
	
		SET @Index += 1;
	END

	RETURN @OutputString;
END
