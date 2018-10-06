
CREATE FUNCTION [Controller].[fnGetDateEndOfMonthOnSpecificDay](
	@CurrentDate date,
	@FirstDayOfWeek tinyint,
	@BespokeMonthEndDayOfWeek tinyint
)
	RETURNS DATE
AS
BEGIN
	-- Get the last day of the current month based on @BespokeMonthEndDayOfWeek
	DECLARE @MonthEndDate date = DATEADD(DAY,-1,DATEADD(MONTH,1,DATEFROMPARTS(YEAR(@CurrentDate),MONTH(@CurrentDate),1)));
	DECLARE @DaysInCurrentMonth int = DAY(@MonthEndDate);

	-- Note: if this were a proc we could simply SET DATEFIRST @BespokeMonthEndDayOfWeek;
	DECLARE @MonthEndDayOfWeek tinyint = (
			DATEPART(DW,@MonthEndDate) + 
			(CASE
				WHEN (@@DATEFIRST >= @FirstDayOfWeek)
				THEN (@@DATEFIRST - @FirstDayOfWeek)
				ELSE (@@DATEFIRST + (7 - @FirstDayOfWeek)) 
			END)
		) % 7;

	DECLARE @DayAdjustment int =
		(CASE
			WHEN (@MonthEndDayOfWeek >= @BespokeMonthEndDayOfWeek)
			THEN (@MonthEndDayOfWeek - @BespokeMonthEndDayOfWeek)
			ELSE (@MonthEndDayOfWeek + (7 - @BespokeMonthEndDayOfWeek))
		END);

	DECLARE @BespokeMonthEndDate date = DATEADD(DAY,-@DayAdjustment, @MonthEndDate);

	RETURN @BespokeMonthEndDate;
END
