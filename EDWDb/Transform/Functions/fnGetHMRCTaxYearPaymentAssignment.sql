
CREATE FUNCTION [Transform].[fnGetHMRCTaxYearPaymentAssignment](
	@TaxYearBalance numeric(18,2),	-- What is owed for the year
	@IsOverPayment bit, -- The amount is greater than what is still owed on the account
	@Last2FirstTaxYearBalanceIndex int, -- Is it the last balance to be assigned 
	@RunningTotalDifferential numeric(18,2), -- How much is still owed
	@PreviousYearRunningTotalDifferential numeric(18,2), -- How much was still owed when the previous transaction was assigned
	@TransactionAmount numeric(18,2) -- What is the transaction amount
) RETURNS numeric(18,2)
AS
BEGIN
	DECLARE @ReturnValue numeric(18,2);

	SET @ReturnValue =
		(CASE
			WHEN (@RunningTotalDifferential > 0.00) -- not all the available payment amount has been assigned
			THEN
				(CASE
					WHEN (@IsOverPayment = 1)
					THEN 
						(CASE
							WHEN (@Last2FirstTaxYearBalanceIndex > 1) -- there is at least one other balance that the amount could be applied to
							THEN [Transform].[fnGetLesserValue](@TaxYearBalance, ISNULL(@PreviousYearRunningTotalDifferential,@TransactionAmount) - @RunningTotalDifferential)
							ELSE ISNULL(@PreviousYearRunningTotalDifferential,@TransactionAmount) -- if nothing was assigned in a previous year, then assign the whole amount
						END)
					ELSE 
						(CASE
							WHEN (@TransactionAmount > @RunningTotalDifferential) -- got more than enough to cover the amount
							THEN [Transform].[fnGetLesserValue](@TaxYearBalance, ISNULL(@PreviousYearRunningTotalDifferential,@TransactionAmount) - @RunningTotalDifferential)
							ELSE @TransactionAmount
						END)
				END)
			ELSE 
				(CASE
					WHEN (@PreviousYearRunningTotalDifferential > 0.00)
					THEN
						(CASE
							WHEN (@TransactionAmount > @PreviousYearRunningTotalDifferential)
							THEN @PreviousYearRunningTotalDifferential
							ELSE @TransactionAmount
						END)
					ELSE @TransactionAmount
				END) 
		END);

	RETURN @ReturnValue;
END
