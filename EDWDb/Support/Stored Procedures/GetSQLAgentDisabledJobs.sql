
CREATE PROCEDURE [Support].[GetSQLAgentDisabledJobs](
	@LastQueryTime datetime,
	@DisabledSQLAgentJobsXml xml OUTPUT
)
AS
BEGIN
	SELECT @DisabledSQLAgentJobsXml = (
		SELECT
			jobs.[name] AS 'JobName',
			CONVERT(char(22),jobs.[date_modified],121) AS 'td'
		FROM [msdb].[dbo].[sysjobs] AS jobs
		WHERE (jobs.[enabled] = 0)
		ORDER BY
			[JobName]
		FOR XML RAW('tr'), ELEMENTS
	)
	RETURN(0);
END
