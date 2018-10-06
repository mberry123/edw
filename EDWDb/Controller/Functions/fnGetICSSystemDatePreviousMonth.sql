
CREATE FUNCTION [Controller].[fnGetICSSystemDatePreviousMonth](
	@ReturnMonthEndDate bit
)
	RETURNS DATE
AS
BEGIN
	DECLARE @SystemDate date = CAST([Controller].[fnGetExecutionState]('ICSSystemDateLoaded') AS date);

	-- Get the month end
	DECLARE @MonthEndDate date = CAST(EOMONTH(@SystemDate) AS date);

	-- If the month hasn't finished, get the previous month
	DECLARE @PreviousMonthEndDate date = 
		(CASE
			WHEN (@MonthEndDate > @SystemDate)
			THEN DATEADD(DAY,-1,DATEFROMPARTS(YEAR(@MonthEndDate),MONTH(@MonthEndDate),1))
			ELSE @MonthEndDate -- the current system date is the previous month end
		END);

	-- Get the beginning of the month
	DECLARE @PreviousMonthStartDate date = DATEFROMPARTS(YEAR(@PreviousMonthEndDate),MONTH(@PreviousMonthEndDate),1);

	-- Return either the start or end depending on what the caller has asked for
	DECLARE @ReturnDate date =
		(CASE @ReturnMonthEndDate
			WHEN 1 THEN @PreviousMonthEndDate
			ELSE @PreviousMonthStartDate
		END);

	RETURN @ReturnDate;
END;
