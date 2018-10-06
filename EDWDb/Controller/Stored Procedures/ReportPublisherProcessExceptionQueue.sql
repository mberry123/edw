
CREATE PROCEDURE [Controller].[ReportPublisherProcessExceptionQueue]
AS
BEGIN
	DECLARE @ApplicationName sysname = N'ReportPublisher'
		,@thisServiceName sysname = N'ReportPublisher.Exception.Service';

	DECLARE @ConversationHandle uniqueidentifier,
		@ConversationGroupID uniqueidentifier,
		@MessageType sysname,
		@MessageBody varbinary(MAX),
		@InitiatorServiceName nvarchar(512);

	WHILE (1 = 1)
		BEGIN
			SET @ConversationHandle = NULL;

			RECEIVE TOP(1)  
				@ConversationHandle = [conversation_handle],
				@ConversationGroupID = [conversation_group_id],
				@MessageType = [message_type_name], 
				@MessageBody = [message_body],
				@InitiatorServiceName = [service_name]
			FROM [Controller].[ReportPublisherExceptionQueue];

			IF (@ConversationHandle IS NULL)
				BEGIN
					BREAK;
				END
			ELSE IF (@MessageType = N'//ReportPublisher/Message/Start')
				BEGIN
					-- extract batch info...
					DECLARE @BatchXml xml = CAST(@MessageBody AS xml);
					DECLARE @BatchCode varchar(64) = @BatchXml.value('(/Batch/@Code)[1]','varchar(64)');

					PRINT N'Processing Batch {' + @BatchCode + N'} on conversation {' + CAST(@ConversationHandle AS nchar(36)) + N'}...';

					-- logging
					EXEC [Controller].[LogEvent] @ApplicationName = @ApplicationName, @ServiceName = @thisServiceName, @ConversationHandle = @ConversationHandle
						,@EventType = 'Started', @EventStatus = 'Succeeded', @EventDetails = @BatchXml;

					-- send a message to failed service
					DECLARE @FailedConversationHandle uniqueidentifier = NULL;
					EXEC [Controller].[SendMessage] @ConversationHandle = @FailedConversationHandle OUTPUT
						,@InitiatorServiceName = @thisServiceName
						,@TargetServiceName = N'ReportPublisher.Failed.Service'
						,@ContractName = N'//ReportPublisher/Contract/Failed'
						,@MessageType = N'//ReportPublisher/Message/Start'
						,@MessageBody = @BatchXml;

					END CONVERSATION @FailedConversationHandle;

					-- logging
					EXEC [Controller].[LogEvent] @ApplicationName = @ApplicationName, @ServiceName = @thisServiceName, @ConversationHandle = @ConversationHandle
						,@EventType = 'Completed', @EventStatus = 'Succeeded', @EventDetails = @BatchXml;
				END
			ELSE IF (@MessageType = N'http://schemas.microsoft.com/SQL/ServiceBroker/EndDialog')
				BEGIN
					END CONVERSATION @ConversationHandle;
					PRINT 'Message {' + CAST(@ConversationHandle AS nchar(36)) + '} conversation ended';
				END
			ELSE
				BEGIN
					-- Ignore the message
					PRINT 'Message {' + CAST(@ConversationHandle AS nchar(36)) + '} ignored due to invalid type';
				END
		END
END;
