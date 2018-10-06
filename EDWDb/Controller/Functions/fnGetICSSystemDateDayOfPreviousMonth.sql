

CREATE FUNCTION [Controller].[fnGetICSSystemDateDayOfPreviousMonth](
	@DayNumber int
)
	RETURNS date
AS
BEGIN
	--Get ICS system date
	DECLARE @SystemDate date = CAST([Controller].[fnGetExecutionState]('ICSSystemDateLoaded') AS date);

	--Calculate the date of the day of the ICS system month
	DECLARE @DayDate date = DATEFROMPARTS(YEAR(@systemDate), MONTH(DATEADD(M,-1,@systemDate)), @DayNumber);

	RETURN @DayDate
	
	;
END;
