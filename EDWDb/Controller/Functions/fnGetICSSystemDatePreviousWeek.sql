
CREATE FUNCTION [Controller].[fnGetICSSystemDatePreviousWeek](
	@WeekStartingDay tinyint,
	@ReturnWeekEndDate bit
)
	RETURNS DATE
AS
BEGIN
	DECLARE @SystemDate date = CAST([Controller].[fnGetExecutionState]('ICSSystemDateLoaded') AS date);

	-- Get the day of the week and apply the intended first day of the week
	-- Note: if this were a proc we could simply SET DATEFIRST @WeekStartingDay;
	DECLARE @SystemDayOfWeek tinyint = (
			DATEPART(DW,@SystemDate) + 
			(CASE
				WHEN (@@DATEFIRST >= @WeekStartingDay)
				THEN (@@DATEFIRST - @WeekStartingDay)
				ELSE (@@DATEFIRST + (7 - @WeekStartingDay)) 
			END)
		) % 7;

	-- Adjust the day by a week
	DECLARE @AdjustmentDays int = (@SystemDayOfWeek - 1) + 7;

	-- Get the start and end of the previous week based on the @WeekStartingDay 
	DECLARE @PreviousWeekStartDate date = DATEADD(DAY,-@AdjustmentDays,@SystemDate);
	DECLARE @PreviousWeekEndDate date = DATEADD(DAY,6,@PreviousWeekStartDate);

	-- Return either the start or end depending on what the caller has asked for
	DECLARE @ReturnDate date =
		(CASE @ReturnWeekEndDate
			WHEN 1 THEN @PreviousWeekEndDate
			ELSE @PreviousWeekStartDate
		END);

	RETURN @ReturnDate;
END;
