
CREATE PROC [Controller].[ReportPublisherPurgeFailures]
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @FailedConversationHandle uniqueidentifier,
		@FailedMessageType sysname;

	WHILE (1 = 1)
		BEGIN
			SET @FailedConversationHandle = NULL;

			RECEIVE TOP(1)  
				@FailedConversationHandle = [conversation_handle],
				@FailedMessageType = [message_type_name]
			FROM [Controller].[ReportPublisherFailedQueue];

			IF (@FailedConversationHandle IS NULL)
				BEGIN
					BREAK;
				END
			ELSE IF (@FailedMessageType = N'//ReportPublisher/Message/Start')
				BEGIN
					PRINT 'Message {' + CAST(@FailedConversationHandle AS nchar(36)) + '} purged';
				END
			ELSE IF (@FailedMessageType = N'http://schemas.microsoft.com/SQL/ServiceBroker/EndDialog')
				BEGIN
					END CONVERSATION @FailedConversationHandle;
					PRINT 'Message {' + CAST(@FailedConversationHandle AS nchar(36)) + '} conversation ended';
				END
			ELSE
				BEGIN
					-- Ignore the message
					PRINT 'Message {' + CAST(@FailedConversationHandle AS nchar(36)) + '} ignored due to invalid type';
				END
		END
END
