
CREATE PROCEDURE [Controller].[ReportPublisherSendExecutionCompletionMessage](
	@ConversationHandle uniqueidentifier
)
AS
BEGIN
	DECLARE @RC int = 0;

	DECLARE @ApplicationName sysname = 'ReportPublisher';

	BEGIN TRY
		-- get the latest execution event details from the service log
		DECLARE 
			@ServiceName sysname,
			@BatchXml xml;

		SELECT
			@ServiceName = [ServiceName]
			,@BatchXml = [EventDetails]
		FROM [Controller].[ServiceEventLog]
		WHERE  ([ApplicationName] = @ApplicationName)
			AND([EventType] = 'Executed')
			AND([ConversationHandle] = @ConversationHandle);

		-- tell the controller that we are done
		EXEC [Controller].[SendMessage] @ConversationHandle = @ConversationHandle OUTPUT,
			@InitiatorServiceName = @ServiceName,
			@TargetServiceName = N'ReportPublisher.Controller.Service',
			@ContractName = N'//ReportPublisher/Contract/Asynchronous',
			@MessageType = N'//ReportPublisher/Message/Complete',
			@MessageBody = @BatchXml;

		-- our work is done, so end the conversation
		END CONVERSATION @ConversationHandle;

		-- log it
		EXEC [Controller].[LogEvent] @ApplicationName = @ApplicationName, @ServiceName = @ServiceName, @ConversationHandle = @ConversationHandle
			,@EventType = 'Completed', @EventStatus = 'Succeeded', @EventDetails = @BatchXml;

	END TRY
	BEGIN CATCH
		SET @RC = 50001;
		DECLARE @ExceptionMessage nvarchar(2000) = N'Failed to complete package execution: ' + CHAR(10) + ERROR_MESSAGE();
		THROW @RC, @ExceptionMessage, 1;
	END CATCH

	RETURN(@RC);
END

