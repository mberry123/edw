
CREATE PROCEDURE [Controller].[ReportPublisherAutomatedRetryService]
WITH EXECUTE AS OWNER
AS

DECLARE @BatchName sysname;
DECLARE @ReportName sysname;


DECLARE @RetryReportCursor AS CURSOR;


SET @RetryReportCursor =  CURSOR FOR
      SELECT 
        DISTINCT 
        [EventDetails].value('(/Batch/@Name)[1]','varchar(64)') AS 'BatchName'
        ,[EventDetails].value('(/Batch/Report/@Name)[1]','varchar(64)') AS 'ReportName'
    FROM [Controller].[ServiceEventLog]
    WHERE ApplicationName = 'ReportPublisher'
	AND [EventDetails].value('(count(//*[@FailedReportCount]))','int') > 0
	AND [EventDetails].value('(/Batch/Report/@Name)[1]','varchar(64)') IS NOT NULL
	AND [EventDetails].value('(count(/Batch/Report/Exception))','int') > 0
        AND EventDateTime > CAST(GETDATE() AS DATE);

OPEN @RetryReportCursor;

FETCH NEXT FROM @RetryReportCursor INTO @BatchName, @ReportName;

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC [Controller].[ReportPublisherRetryService]  @BatchName, @ReportName;

	FETCH NEXT FROM @RetryReportCursor INTO @BatchName, @ReportName;
END

CLOSE @RetryReportCursor;
DEALLOCATE @RetryReportCursor;
