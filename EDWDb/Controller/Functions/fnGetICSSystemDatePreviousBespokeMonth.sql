
CREATE FUNCTION [Controller].[fnGetICSSystemDatePreviousBespokeMonth](
	@FirstDayOfWeek tinyint,
	@BespokeMonthEndDayOfWeek tinyint,
	@ReturnMonthEndDate bit
)
	RETURNS DATE
AS
BEGIN
	DECLARE @SystemDate date = CAST([Controller].[fnGetExecutionState]('ICSSystemDateLoaded') AS date);

	DECLARE @ReturnDate date = [Controller].[fnGetDatePreviousBespokeMonth](
		@SystemDate,
		@FirstDayOfWeek,
		@BespokeMonthEndDayOfWeek,
		@ReturnMonthEndDate
	);

	RETURN @ReturnDate;
END;
