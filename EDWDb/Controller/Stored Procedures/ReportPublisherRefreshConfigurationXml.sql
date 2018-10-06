
CREATE PROCEDURE [Controller].[ReportPublisherRefreshConfigurationXml](
	@OriginalBatchXml xml,
	@RefreshedBatchXml xml OUTPUT
)
AS
BEGIN
	-- get the failed batch attributes that we still need
	DECLARE @FailedBatchCode int = @OriginalBatchXml.value('(/Batch/@Code)[1]','int'),
		@FailedBatchScheduleEventDate datetime = @OriginalBatchXml.value('(/Batch/@ScheduleEventDate)[1]','datetime');

	-- get the report configuration again (in case it has been rectified to sort out the failure)
	DECLARE @ConfigurationXml xml([Controller].[ReportPublisherXmlSchema]);
	EXEC [Controller].[ReportPublisherConfigurationXml]
		@ConfigurationXml OUTPUT;

	-- get the refreshed batch config
	DECLARE @ConfigBatchXml xml = @ConfigurationXml.query('//Batch[@Code = sql:variable("@FailedBatchCode")]');

	-- stamp the batch xml with the schedule event date to identify an instance of a batch
	SET @ConfigBatchXml.modify('insert attribute ScheduleEventDate {sql:variable("@FailedBatchScheduleEventDate")} into (/Batch)[1]');

	IF (@ConfigBatchXml.exist('//Report') = 0)
		RAISERROR('The refreshed batch (%s) xml does not contain any report configuration. Please investigate manually.',16,1, @FailedBatchCode);
		
	--ok, we have some nice refreshed config
	SET @RefreshedBatchXml = @ConfigBatchXml;

	RETURN(0);
END;
