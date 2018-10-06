
CREATE FUNCTION [Controller].[fnGetICSSystemDateCurrentBespokeQuarter](
	@FirstMonthOfBespokeCalendarYear tinyint,
	@ReturnQuarterEndDate bit
)
	RETURNS DATE
AS
BEGIN
	DECLARE @SystemDate date = CAST([Controller].[fnGetExecutionState]('ICSSystemDateLoaded') AS date);

	DECLARE @ReturnDate date = [Controller].[fnGetDateCurrentBespokeQuarter](
			@SystemDate,
			@FirstMonthOfBespokeCalendarYear,
			@ReturnQuarterEndDate
		);

	RETURN @ReturnDate;
END;
