
CREATE FUNCTION [Transform].[fnGetHMRCTaxYearReversalAdjustment](
	@TaxYearRunningBalance numeric(18,2), -- What is owed in total thus far
	@TaxYearBalance numeric(18,2),	-- What is owed for the year		
	@PreviousPaidToDateBalance numeric(18,2), -- What has been paid so far (not including the current reversal)
	@IsPreviousOverPayment bit, -- Was the previous assignment an overpayment
	@PreviousReversals numeric(18,2), -- What has been reversed before
	@ReversalValue numeric(18,2) -- What is the reversal
) RETURNS numeric(18,2)
AS
BEGIN
	DECLARE @ReturnValue numeric(18,2);

	DECLARE @TaxYearOutstandingBalance numeric(18,2) = @TaxYearBalance - (@TaxYearRunningBalance - @PreviousPaidToDateBalance);

	SET @ReturnValue =
		(CASE
			WHEN (@PreviousPaidToDateBalance > @TaxYearRunningBalance)
			THEN 
				(CASE
					WHEN (ISNULL(@IsPreviousOverPayment,0) = 0) --CHANGE
					THEN @ReversalValue + (@PreviousPaidToDateBalance - @TaxYearRunningBalance)
					ELSE @ReversalValue
				END)
			ELSE -([Transform].[fnGetLesserValue](-@ReversalValue, @TaxYearOutstandingBalance))
		END);

	RETURN @ReturnValue;
END
