
CREATE PROCEDURE [Support].[GetReportPublisherExceptions](
	@LastQueryTime datetime,
	@ReportPublisherExceptionsXml xml OUTPUT
)
AS
BEGIN
	EXEC sp_executesql N'
		SELECT @ReportPublisherExceptionsXml = (
			SELECT CAST([message_enqueue_time] AS date) AS ''ExceptionDate'', COUNT(*) AS ''td''
			FROM [Controller].[ReportPublisherFailedQueue]
			WHERE ([message_type_name] = ''//ReportPublisher/Message/Start'')
			GROUP BY
					CAST([message_enqueue_time] AS date)
			ORDER BY
				[ExceptionDate]
			FOR XML RAW(''tr''), ELEMENTS
		)',
		N'@ReportPublisherExceptionsXml xml OUTPUT',
		@ReportPublisherExceptionsXml OUTPUT;

	RETURN(0);
END
