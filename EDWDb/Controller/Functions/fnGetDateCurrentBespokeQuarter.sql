
CREATE FUNCTION [Controller].[fnGetDateCurrentBespokeQuarter](
	@CheckDate date,
	@FirstMonthOfBespokeCalendarYear tinyint,
	@ReturnQuarterEndDate bit
)
	RETURNS DATE
AS
BEGIN
	
	-- Take one day off the ICS System date as that will always be the current date (given that the day end snapshot has been created)
	SELECT @CheckDate = DATEADD(dd,DAY(@CheckDate)*-1,@CheckDate)

	-- Get the Quarter end
	DECLARE @GregorianCalendarMonth tinyint = CAST(MONTH(@CheckDate) AS tinyint);
	DECLARE @BespokeCalendarMonth tinyint = (
			(CASE
				WHEN (@GregorianCalendarMonth >= @FirstMonthOfBespokeCalendarYear)
				THEN (@GregorianCalendarMonth - @FirstMonthOfBespokeCalendarYear)
				ELSE (@GregorianCalendarMonth + (12 - @FirstMonthOfBespokeCalendarYear)) 
			END) + 1
		);

	DECLARE @BespokeQuarter tinyint = (@BespokeCalendarMonth/3)+1;

	DECLARE @MonthAdjustment tinyint = 
		(CASE 
			WHEN (@BespokeCalendarMonth % 3 = 0) THEN 2
			ELSE (@BespokeCalendarMonth % 3) -1
		END); 

	DECLARE @BespokeQuarterStartDate date = DATEADD(MONTH,-@MonthAdjustment,DATEFROMPARTS(YEAR(@CheckDate),MONTH(@CheckDate),1));
	DECLARE @BespokeQuarterEndDate date = EOMONTH(@BespokeQuarterStartDate,2);

	-- Return either the start or end depending on what the caller has asked for
	DECLARE @ReturnDate date =
		(CASE @ReturnQuarterEndDate
			WHEN 1 THEN @BespokeQuarterEndDate
			ELSE @BespokeQuarterStartDate
		END);

	RETURN @ReturnDate;
END;
