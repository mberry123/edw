
CREATE FUNCTION [Controller].[fnGetICSSystemDateSpecificDay](
	@DaysSinceCurrent int
)
	RETURNS date
AS
BEGIN
	-- get the system date
	DECLARE @SystemDate date = CAST([Controller].[fnGetExecutionState]('ICSSystemDateLoaded') AS date);

	-- get the previous day
	DECLARE @PreviousDayDate date = DATEADD(DAY, @DaysSinceCurrent, @SystemDate);

	RETURN @PreviousDayDate;
END;
