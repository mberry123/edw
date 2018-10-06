
CREATE FUNCTION [Report].[fnMER15GetBatchNumberForDate]
(
	@DateForBatch smalldatetime
	,@FirstBatchDate smalldatetime
	,@pForcePreviousEoM bit 
)

RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @LastBatchNumber VARCHAR(50);
--
	If @FirstBatchDate IS NULL
		RETURN NULL;
--
	If ISDATE(@FirstBatchDate) != 1
		RETURN NULL;
--
	IF @DateForBatch IS NULL
		SET @DateForBatch = GETDATE()
--
	IF @pForcePreviousEoM = 1
		SET @DateForBatch = DATEADD(DAY, DAY(@DateForBatch) * - 1, @DateForBatch)
--
	SET @LastBatchNumber = TRY_CONVERT(VARCHAR(50),DATEDIFF(MONTH,@FirstBatchDate,@DateForBatch));	
	RETURN @LastBatchNumber;
END
