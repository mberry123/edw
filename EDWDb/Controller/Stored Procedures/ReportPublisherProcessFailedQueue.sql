
CREATE PROCEDURE [Controller].[ReportPublisherProcessFailedQueue](
	@SingleProcessConversationHandle uniqueidentifier = NULL
)
AS
BEGIN
	DECLARE @ApplicationName sysname = N'ReportPublisher'
		,@thisServiceName sysname = N'ReportPublisher.Failed.Service';

	WHILE (1 = 1)
		BEGIN
			DECLARE @FailedConversationHandle uniqueidentifier = NULL,
				@ConversationGroupID uniqueidentifier = NULL,
				@MessageType sysname = NULL,
				@FailedMessageBody varbinary(MAX) = NULL;

			IF (@SingleProcessConversationHandle IS NULL)
				BEGIN
					;RECEIVE TOP(1)  
						@FailedConversationHandle = [conversation_handle],
						@ConversationGroupID = [conversation_group_id],
						@MessageType = [message_type_name], 
						@FailedMessageBody = [message_body] 
					FROM [Controller].[ReportPublisherFailedQueue];
				END
			ELSE
				BEGIN
					;RECEIVE TOP(1)
						@FailedConversationHandle = [conversation_handle],
						@ConversationGroupID = [conversation_group_id],
						@MessageType = [message_type_name], 
						@FailedMessageBody = [message_body] 
					FROM [Controller].[ReportPublisherFailedQueue]
					WHERE conversation_handle = @SingleProcessConversationHandle;
				END

			IF (@FailedConversationHandle IS NULL)
				BEGIN
					BREAK;
				END
			ELSE IF (@MessageType = N'//ReportPublisher/Message/Start')
				BEGIN
					PRINT N'Trying to resend the message {' + CAST(@FailedConversationHandle AS nchar(36)) + N'}';
					-- retry search
					DECLARE @FailedBatchXml xml = CAST(@FailedMessageBody AS xml);

					-- refresh the batch config
					DECLARE @RetryBatchXml xml = NULL;
					EXEC [Controller].[ReportPublisherRefreshConfigurationXml]
						@OriginalBatchXml = @FailedBatchXml,
						@RefreshedBatchXml = @RetryBatchXml OUTPUT;

					-- send batch message to queue
					DECLARE @ConversationHandle uniqueidentifier = NULL;

					EXEC [Controller].[SendMessage]
						@ConversationHandle = @ConversationHandle OUTPUT,
						@InitiatorServiceName = @thisServiceName,
						@TargetServiceName = N'ReportPublisher.Controller.Service',
						@ContractName = N'//ReportPublisher/Contract/Controller',
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

					PRINT N'Message {' + CAST(@FailedConversationHandle AS nchar(36)) + '} re-processed';
				END
			ELSE IF (@MessageType = N'http://schemas.microsoft.com/SQL/ServiceBroker/EndDialog')
				BEGIN
					END CONVERSATION @FailedConversationHandle;
					PRINT 'Message {' + CAST(@FailedConversationHandle AS nchar(36)) + '} conversation ended';
					-- if we have only been asked to process one failure, then lets quit
					IF(@SingleProcessConversationHandle IS NOT NULL)
						BREAK;
				END
			ELSE
				BEGIN
					-- Ignore the message
					PRINT 'Message {' + CAST(@FailedConversationHandle AS nchar(36)) + '} ignored due to invalid type';
				END
		END
END
