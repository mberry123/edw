
CREATE PROCEDURE [Support].[GetSQLAgentJobExceptions](
	@LastQueryTime datetime,
	@FailedSQLAgentJobsXml xml OUTPUT
)
AS
BEGIN
	WITH JobHistory AS (
		SELECT
			jobs.[name] AS 'JobName'
			,(CASE history.[run_status] WHEN 1 THEN 1 ELSE 0 END)  AS 'Successes'
			,(CASE history.[run_status] WHEN 0 THEN 1 ELSE 0 END) AS 'Failures'
			,(CASE
					(LAST_VALUE(history.[run_status]) OVER(
						PARTITION BY jobs.[name]
						ORDER BY CONVERT(date,CAST(history.[run_date] AS char(10)),112))
					)
				WHEN 1 THEN 'Succeeded'
				ELSE 'Failed'
			END) AS 'CurrentStatus'
		FROM [msdb].[dbo].[sysjobs] AS jobs
		LEFT JOIN [msdb].[dbo].[sysjobhistory] AS history
			ON (history.[job_id] = jobs.[job_id])
			AND(history.[step_id] = 0)
			AND([Support].[GetDateFromInt](history.[run_date],history.[run_time]) >= @LastQueryTime)
		LEFT JOIN (
				SELECT DISTINCT
						[job_id]
						,FIRST_VALUE([run_status]) OVER(
							PARTITION BY [job_id]
							ORDER BY [instance_id] DESC
						) AS 'status'
				FROM [msdb].[dbo].[sysjobhistory]
				WHERE ([step_id] = 0)
		) AS LastJobExec
			ON (LastJobExec.[job_id] = jobs.[job_id])
		WHERE (history.[job_id] IS NOT NULL)
				OR(LastJobExec.[status] <> 1)
	)
	SELECT @FailedSQLAgentJobsXml = (
		SELECT 
			AllJobs.[JobName]
			,SUM([Successes]) AS 'td'
			,SUM([Failures]) AS 'Failures'
			,MIN([CurrentStatus]) AS 'td'
		FROM JobHistory AS AllJobs
		INNER JOIN (
			SELECT DISTINCT [JobName]
			FROM JobHistory
			WHERE ([Failures] = 1)
					OR([CurrentStatus] <> 'Succeeded')
		) AS JobsWithFailures
			ON (JobsWithFailures.[JobName] = AllJobs.[JobName])
		GROUP BY
			AllJobs.[JobName]
		ORDER BY
			AllJobs.[JobName]
		FOR XML RAW('tr'), ELEMENTS
	)

	RETURN(0);
END
