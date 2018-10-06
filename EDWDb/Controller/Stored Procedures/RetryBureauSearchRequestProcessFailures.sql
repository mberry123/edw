

create PROCEDURE [Controller].[RetryBureauSearchRequestProcessFailures]
AS

DECLARE @ExecutionTime DATETIME;

SELECT @ExecutionTime = GETDATE();


IF CONVERT(TIME,@ExecutionTime) < '20:00:00.0000000'
BEGIN
EXEC [Controller].[BureauSearchRequestProcessFailures];
END;

IF CONVERT(TIME,@ExecutionTime) >= '20:30:00.0000000'
BEGIN
EXEC [Controller].[BureauSearchRequestPurgeFailures] 
END;


