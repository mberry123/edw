
CREATE FUNCTION [Controller].[fnGetICSSystemDatePreviousHalfYear](
	@ReturnHalfYearEndDate bit
)
	RETURNS DATE
AS
BEGIN
	DECLARE @SystemDate date = CAST([Controller].[fnGetExecutionState]('ICSSystemDateLoaded') AS date);
	
	-- Get the appropriate half year
	DECLARE @PreviousHalfYearStartDate date = 
		(CASE
			-- when in the second half of the year, including the last day of the first half
			WHEN  (MONTH(@SystemDate) = 6 AND DAY(@SystemDate) = 30)
				OR(MONTH(@SystemDate) BETWEEN 6 AND 11)
				OR(MONTH(@SystemDate) = 12 AND DAY(@SystemDate) < 31)
			THEN DATEFROMPARTS(YEAR(@SystemDate),1,1)
			-- when in the first half of the year
			WHEN  (MONTH(@SystemDate) BETWEEN 1 AND 6)
			THEN DATEADD(YEAR,-1,DATEFROMPARTS(YEAR(@SystemDate),7,1))
			-- when the last day of the year
			ELSE DATEFROMPARTS(YEAR(@SystemDate),7,1)
		END)

	-- Get the last day of the half year
	DECLARE @PreviousHalfYearEndDate date = DATEADD(DAY,-1,DATEADD(MONTH,6,@PreviousHalfYearStartDate));

	-- Return either the start or end depending on what the caller has asked for
	DECLARE @ReturnDate date =
		(CASE @ReturnHalfYearEndDate
			WHEN 1 THEN @PreviousHalfYearEndDate
			ELSE @PreviousHalfYearStartDate
		END);

	RETURN @ReturnDate;
END;
