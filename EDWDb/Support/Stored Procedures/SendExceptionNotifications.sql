

CREATE PROCEDURE [Support].[SendExceptionNotifications](
	@JobID uniqueidentifier = NULL,
	@FirstExceptionEventTime datetime = NULL
)
AS
BEGIN
	SET NOCOUNT ON;
	-- get the time of the last job run
	DECLARE @JobLastRunTime datetime = [Support].[GetJobLastRunTime](@JobID, NULL);

	-- define the datetime filter for all exception events
	DECLARE @LastQueryTime datetime = COALESCE(@JobLastRunTime, @FirstExceptionEventTime);

	DECLARE @EmailTemplateHTML nvarchar(max);
	SET @EmailTemplateHTML = '<html>
		<head>
			<style>
				p {
					font-size: 9pt;
					font-family: verdana;
				}
				h2 {
					font-size: 11pt;
					font-family: verdana;
					font-style: sans-serif;
					color: rgb(211,7,40);
				}
				h3 {
					font-size: 9pt;
					font-family: verdana;
					font-style: sans-serif;
				}
				dir {
					margin: 0px;
				}
				td {
					border: solid black 1px;
					padding-left:5px;
					padding-right:5px;
					padding-top:1px;
					padding-bottom:1px;
					font: 11px arial,sans-serif;
				}
			</style>
		</head>
		<body>
			<p>Please investigate the following exceptions and take appropriate action to resolve:</p>
			<table WIDTH=100% BORDER=0>
				<tr>
					<td WIDTH=50% VALIGN=TOP style="border:none">
						<h2>SQL Agent Job Exceptions (since #LASTNOTIFICATION#):</h2>
						<dir>
							<table cellpadding=0 cellspacing=0 border=0>
								<tr bgcolor=#FFEFD8>
									<td align=center><b>Job Name</b></td>
									<td align=center><b>Successes</b></td>
									<td align=center><b>Failures</b></td>
									<td align=center><b>Current Status</b></td>
								</tr>
								#FAILEDJOBS#
							</table>
						</dir>
						<h2>SSIS Package Exceptions (since #LASTNOTIFICATION#):</h2>
						<dir>
							<table cellpadding=0 cellspacing=0 border=0>
								<tr bgcolor=#FFEFD8>
									<td align=center><b>Package Name</b></td>
									<td align=center><b>Successes</b></td>
									<td align=center><b>Cancelled</b></td>
									<td align=center><b>Failures</b></td>
									<td align=center><b>Ended Unexpectedly</b></td>
									<td align=center><b>Current Status</b></td>
								</tr>
								#FAILEDPACKAGES#
							</table>
						</dir>
						<h2>Disabled SQL Agent Jobs:</h2>
						<dir>
							<table cellpadding=0 cellspacing=0 border=0>
								<tr bgcolor=#FFEFD8>
									<td align=center><b>Job Name</b></td>
									<td align=center><b>Date Disabled</b></td>
								</tr>
								#DISABLEDJOBS#
							</table>
						</dir>
				</tr>
			</table>
		</body>
	</html>';

	SET @EmailTemplateHTML = REPLACE(@EmailTemplateHTML,'#SERVERNAME#',@@SERVERNAME);

	-- SQL Agent Job Exceptions --------------------------
	DECLARE @FailedSQLAgentJobsXml xml;
	EXEC [Support].[GetSQLAgentJobExceptions]
		@LastQueryTime,
		@FailedSQLAgentJobsXml OUTPUT;

	DECLARE @SQLAgentJobExceptionCount int = (
		SELECT
			ISNULL(SUM(fragment.element.value('.','int')),0)
		FROM @FailedSQLAgentJobsXml.nodes('//Failures') fragment(element)
	);

	DECLARE @FailedSQLAgentJobs nvarchar(max) = ISNULL(CAST(@FailedSQLAgentJobsXml AS nvarchar(max)),N'');
	SET @FailedSQLAgentJobs = REPLACE(@FailedSQLAgentJobs,'JobName','td');
	SET @FailedSQLAgentJobs = REPLACE(@FailedSQLAgentJobs,'Failures','td');
	SET @EmailTemplateHTML = REPLACE(@EmailTemplateHTML,'#LASTNOTIFICATION#',CAST(@LastQueryTime AS varchar(21)));
	SET @EmailTemplateHTML = REPLACE(@EmailTemplateHTML,'#FAILEDJOBS#',@FailedSQLAgentJobs);

	-- SSIS Package Exceptions --------------------------
	DECLARE @SSISPackageExceptionsXml xml;
	EXEC [Support].[GetSSISPackageExceptions]
		@LastQueryTime,
		@SSISPackageExceptionsXml OUTPUT;

	DECLARE @SSISPackageExceptionCount int = (
		SELECT ISNULL(SUM(fragment.element.value('.','int')),0)
		FROM @SSISPackageExceptionsXml.nodes('(//Cancellations, //Failures, //Ends)') fragment(element)
	);

	DECLARE @FailedSSISPackages nvarchar(max) = ISNULL(CAST(@SSISPackageExceptionsXml AS nvarchar(max)),N'');
	SET @FailedSSISPackages = REPLACE(@FailedSSISPackages,'PackageName','td');
	SET @FailedSSISPackages = REPLACE(@FailedSSISPackages,'Success','td');
	SET @FailedSSISPackages = REPLACE(@FailedSSISPackages,'Cancellations','td');
	SET @FailedSSISPackages = REPLACE(@FailedSSISPackages,'Failures','td');
	SET @FailedSSISPackages = REPLACE(@FailedSSISPackages,'Ends','td');
	SET @FailedSSISPackages = REPLACE(@FailedSSISPackages,'CurrentStatus','td');
	SET @EmailTemplateHTML = REPLACE(@EmailTemplateHTML,'#FAILEDPACKAGES#',@FailedSSISPackages);

	-- Disabled SQL Agent Jobs ---------------------------
	DECLARE @DisabledSQLAgentJobsXml xml
	EXEC [Support].[GetSQLAgentDisabledJobs]
		@LastQueryTime,
		@DisabledSQLAgentJobsXml OUTPUT;

	DECLARE @SQLAgentDisabledJobCount int = (
		SELECT
			ISNULL(SUM(1),0)
		FROM @DisabledSQLAgentJobsXml.nodes('//JobName') fragment(element)
	)
	DECLARE @DisabledSQLAgentJobs nvarchar(max) = ISNULL(CAST(@DisabledSQLAgentJobsXml AS nvarchar(max)),N'');
	SET @DisabledSQLAgentJobs = REPLACE(@DisabledSQLAgentJobs,'JobName','td');
	SET @EmailTemplateHTML = REPLACE(@EmailTemplateHTML,'#DISABLEDJOBS#',@DisabledSQLAgentJobs);

	-- Report Publisher Exceptions -----------------------
	DECLARE @ReportPublisherExceptionsXml xml
	EXEC [Support].[GetReportPublisherExceptions]
		@LastQueryTime,
		@ReportPublisherExceptionsXml OUTPUT;

	DECLARE @FailedReportsExceptionCount int = (
		SELECT
			ISNULL(SUM(fragment.element.value('.','int')),0)
		FROM @ReportPublisherExceptionsXml.nodes('//td') fragment(element)
	)
	DECLARE @FailedReports nvarchar(max) = ISNULL(CAST(@ReportPublisherExceptionsXml AS NVARCHAR(max)),N'');
	SET @FailedReports = REPLACE(@FailedReports,'ExceptionDate','td');
	SET @EmailTemplateHTML = REPLACE(@EmailTemplateHTML,'#FAILEDREPORTS#',@FailedReports);
	SET @EmailTemplateHTML = REPLACE(@EmailTemplateHTML,'#REPORT_PUBLISHER_REPORT_URI#',[Controller].[fnGetConfigurationItem]('ReportPublisher.ExceptionReportURI'));

	-- Strategy Scorecard Exceptions ---------------------
	DECLARE @StrategyScorecardExceptionsCount int;
	EXEC [Support].[GetStrategyScorecardExceptions]
		@StrategyScorecardExceptionsCount OUTPUT;

	DECLARE @CasesAwaitingScoring nvarchar(8) = ISNULL(CAST(@StrategyScorecardExceptionsCount AS nvarchar(8)),N'0');
	SET @EmailTemplatehtml = REPLACE(@EmailTemplateHtml,'#CasesAwaitingScoring#',@CasesAwaitingScoring);

	-- Send Notification ---------------------------------
	IF(@SQLAgentJobExceptionCount > 0)
	OR(@SSISPackageExceptionCount > 0)
	OR(@SQLAgentDisabledJobCount > 0)
	OR(@FailedReportsExceptionCount > 0)
	OR(@StrategyScorecardExceptionsCount > 0)
		BEGIN

			DECLARE @NotificationMailProfile sysname = CAST([Controller].[fnGetConfigurationItem]('Support.Notification.MailProfile') AS sysname),
				@NotificationRecipients varchar(max) = CAST([Controller].[fnGetConfigurationItem]('Support.Notification.Recipients') AS varchar(max));

			DECLARE @NotificationSubject varchar(255) = 'EDW - Exception Notification',
				@NotificationDetails nvarchar(max) = @EmailTemplateHTML;

			EXEC [msdb].dbo.sp_send_dbmail
				@profile_name = @NotificationMailProfile
				,@recipients = @NotificationRecipients
				,@subject = @NotificationSubject
				,@body = @NotificationDetails
				,@body_format ='HTML';

			PRINT 'Notification sent to ' + @NotificationRecipients;

		END
END;
