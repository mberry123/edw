
CREATE FUNCTION [Controller].[fnGetDatePreviousBespokeMonth](
	@CheckDate date,
	@FirstDayOfWeek tinyint,
	@BespokeMonthEndDayOfWeek tinyint,
	@ReturnMonthEndDate bit
)
	RETURNS DATE
AS
BEGIN
	-- Get last day of current and previous system month
	DECLARE @BespokeMonthEnd date = [Controller].[fnGetDateEndOfMonthOnSpecificDay](@CheckDate, @FirstDayOfWeek, @BespokeMonthEndDayOfWeek);
	DECLARE @PreviousMonthSystemDate date = DATEADD(MONTH,-1,@CheckDate);
	DECLARE @PreviousBespokeMonthEnd date = [Controller].[fnGetDateEndOfMonthOnSpecificDay](@PreviousMonthSystemDate, @FirstDayOfWeek, @BespokeMonthEndDayOfWeek);

	IF(@BespokeMonthEnd > @CheckDate)
		BEGIN
			SET @BespokeMonthEnd = @PreviousBespokeMonthEnd;
			SET @PreviousMonthSystemDate = DATEADD(MONTH,-2,@CheckDate);
			SET @PreviousBespokeMonthEnd = [Controller].[fnGetDateEndOfMonthOnSpecificDay](@PreviousMonthSystemDate, @FirstDayOfWeek, @BespokeMonthEndDayOfWeek);
		END

	-- Get the first day of the month
	DECLARE @BespokeMonthStart date = DATEADD(DAY,1,@PreviousBespokeMonthEnd);

	-- Return either the start or end depending on what the caller has asked for
	DECLARE @ReturnDate date =
		(CASE @ReturnMonthEndDate
			WHEN 1 THEN @BespokeMonthEnd
			ELSE @BespokeMonthStart
		END);

	RETURN @ReturnDate;
END;
