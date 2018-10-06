
CREATE FUNCTION [Support].[GetJobLastRunTime](
	@JobId UNIQUEIDENTIFIER,
	@JobName [sysname]
)
RETURNS DATETIME
AS
BEGIN
	DECLARE @ReturnValue datetime

	SELECT
		@ReturnValue = MAX(Support.GetDateFromInt(history.[run_date],history.[run_time]))
	FROM [msdb].dbo.sysjobs AS job
	INNER JOIN [msdb].dbo.sysjobhistory AS history
		ON (history.[job_id] = job.[job_id])
	WHERE (job.[job_id] = @JobId)
		OR(job.[name] = @JobName)

	RETURN @ReturnValue
END
