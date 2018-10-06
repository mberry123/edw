
CREATE PROCEDURE [Controller].[ReportPublisherRetryService](
	@BatchName sysname
	,@ReportName sysname = NULL
	,@DebugOnly bit = 0
)
WITH EXECUTE AS OWNER
AS
BEGIN
	DECLARE @ApplicationName sysname = N'ReportPublisher'
		,@thisServiceName sysname = N'ReportPublisher.Start.Service';

	DECLARE @ConfigurationXml xml([Controller].[ReportPublisherXmlSchema]);
	EXEC [Controller].[ReportPublisherConfigurationXml]
		@ConfigurationXml OUTPUT;

	DECLARE @BatchQueueXml xml = @ConfigurationXml;
	DECLARE @RetryBatchXml xml = @BatchQueueXml.query('(//Batch[@Name = sql:variable("@BatchName")])[1]');

	IF(CAST(@RetryBatchXml AS varchar(max)) <> '')
		BEGIN
			IF (@ReportName IS NOT NULL)
			AND(@RetryBatchXml.value('(/Batch/@Type)[1]','sysname') = 'Sequential')
				BEGIN
					-- remove reports that are not included in the list
					SET @RetryBatchXml.modify('delete //Report[@Name != sql:variable("@ReportName")]');
				END

			IF (@DebugOnly = 1)
				BEGIN
					SELECT @RetryBatchXml;
					RETURN;
				END

			DECLARE @RetryEventDate datetime = GETDATE();
			SET @RetryBatchXml.modify('insert attribute ScheduleEventDate {sql:variable("@RetryEventDate")} into (/Batch)[1]');
			SET @RetryBatchXml.modify('insert attribute IsRetry {1} into (/Batch)[1]');

			-- send batch message to queue
			DECLARE @ConversationHandle uniqueidentifier = NULL;

			EXEC [Controller].[SendMessage]
				@ConversationHandle = @ConversationHandle OUTPUT,
				@InitiatorServiceName = @thisServiceName,
				@TargetServiceName = N'ReportPublisher.Controller.Service',
				@ContractName = N'//ReportPublisher/Contract/Synchronous',
				@MessageType = N'//ReportPublisher/Message/Start',
				@MessageBody = @RetryBatchXml;

			EXEC [Controller].[LogEvent] @ApplicationName = @ApplicationName, @ServiceName = @thisServiceName, @ConversationHandle = @ConversationHandle
				,@EventType = 'Controller.Queued', @EventStatus = 'Succeeded', @EventDetails = @RetryBatchXml;

			PRINT N'Message sent to controller queue: ' + CAST(@RetryBatchXml AS nvarchar(max));

			IF(@ConversationHandle IS NOT NULL)
				BEGIN
					-- once we have sent the batch data to the controller service, our work is done
					END CONVERSATION @ConversationHandle;
				END
		END
END

