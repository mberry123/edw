
CREATE FUNCTION [Transform].[fnGetQuarterPeriodFromTime](
	@time time
) RETURNS varchar(50)
AS
BEGIN
	DECLARE @ReturnValue varchar(15);

	DECLARE
		@Hour int = DATEPART(hour,@time),
		@minute int = DATEPART(minute,@time);

	DECLARE
		@PeriodStart time = CAST(DATEADD(hour,@hour,'00:00') AS TIME),
		@PeriodEnd time = CAST(DATEADD(hour,@hour,'00:00') AS TIME);

	SET @ReturnValue =
		(CASE
			WHEN (@minute BETWEEN 0 AND 15) THEN
				CAST(@PeriodStart AS char(5)) + N' to ' + CAST(DATEADD(minute,15,@PeriodEnd) AS char(5))
			WHEN (@minute BETWEEN 16 AND 30) THEN
				CAST(DATEADD(minute,16,@PeriodStart) AS char(5)) + N' to ' + CAST(DATEADD(minute,30,@PeriodEnd) AS char(5))
			WHEN (@minute BETWEEN 31 AND 45) THEN
				CAST(DATEADD(minute,31,@PeriodStart) AS char(5)) + N' to ' + CAST(DATEADD(minute,45,@PeriodEnd) AS char(5))
			ELSE
				CAST(DATEADD(minute,46,@PeriodStart) AS char(5)) + N' to ' + CAST(DATEADD(hour,1,@PeriodEnd) AS char(5))
		END);

	RETURN @ReturnValue;
END
