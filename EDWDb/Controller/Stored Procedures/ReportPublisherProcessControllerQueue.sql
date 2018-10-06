
CREATE PROCEDURE [Controller].[ReportPublisherProcessControllerQueue]
AS
BEGIN
	DECLARE @ApplicationName sysname = N'ReportPublisher';

	DECLARE @thisConversationHandle uniqueidentifier,
		@thisServiceName sysname,
		@thisMessageType sysname,
		@thisMessageBody varbinary(MAX);

	WHILE (1 = 1)
		BEGIN
			SET @thisConversationHandle = NULL;

			RECEIVE TOP(1)  
				@thisConversationHandle = [conversation_handle],
				@thisServiceName = [service_name],
				@thisMessageType = [message_type_name], 
				@thisMessageBody = [message_body] 
			FROM [Controller].[ReportPublisherControllerQueue];

			IF (@thisConversationHandle IS NULL)
				BEGIN
					BREAK;
				END
			ELSE IF (@thisMessageType = N'//ReportPublisher/Message/Start')
				BEGIN
					-- start a conversation with the batch splitter service
					DECLARE @BatchSplitterConversationHandle uniqueidentifier = NULL,
						@RenderBatchXml xml = CAST(@thisMessageBody AS xml);

					-- stamp the batch xml with the conversation handle (we need the attribute to exist for downstream processes)
					SET @RenderBatchXml.modify('insert attribute ConversationHandle {sql:variable("@thisConversationHandle")} into (/Batch)[1]');

					EXEC [Controller].[SendMessage]
						@ConversationHandle = @BatchSplitterConversationHandle OUTPUT,
						@InitiatorServiceName = @thisServiceName,
						@TargetServiceName = N'ReportPublisher.Render.Service',
						@ContractName = N'//ReportPublisher/Contract/Asynchronous',
						@MessageType = N'//ReportPublisher/Message/Start',
						@MessageBody = @RenderBatchXml;

					-- log it
					EXEC [Controller].[LogEvent] @ApplicationName = @ApplicationName, @ServiceName = @thisServiceName, @ConversationHandle = @BatchSplitterConversationHandle
						,@EventType = 'Render.Queued', @EventStatus = 'Succeeded', @EventDetails = @RenderBatchXml;
				END
			ELSE IF (@thisMessageType = N'//ReportPublisher/Message/Complete')
				BEGIN
					-- get the name of the service that sent the message
					DECLARE @SenderServiceName nvarchar(128) = (
						SELECT CAST(sysinfo.[far_service] AS nvarchar(128))
						FROM sys.conversation_endpoints AS sysinfo
						WHERE (sysinfo.[conversation_handle] = @thisConversationHandle)
					);

					-- Ok, the receiving service has done its work, lets hang up
					END CONVERSATION @thisConversationHandle;
					PRINT N'Message {' + CAST(@thisConversationHandle AS nchar(36)) + N'} conversation ended';

					DECLARE @TargetServiceName sysname, @TargetContractName sysname, @TargetEventType varchar(64),
						@TargetMessageType sysname = N'//ReportPublisher/Message/Start';

					IF (@SenderServiceName = N'ReportPublisher.render.Service')
						BEGIN
							SET @TargetServiceName = N'ReportPublisher.Consolidate.Service';
							SET @TargetContractName = N'//ReportPublisher/Contract/Asynchronous';
							SET @TargetEventType = 'Consolidate.Queued';
						END
					ELSE IF (@SenderServiceName = N'ReportPublisher.Consolidate.Service')
						BEGIN
							SET @TargetServiceName = N'ReportPublisher.Move.Service';
							SET @TargetContractName = N'//ReportPublisher/Contract/Asynchronous';
							SET @TargetEventType = 'Move.Queued';
						END
					ELSE
						SET @TargetServiceName = NULL;			

					IF (@TargetServiceName IS NOT NULL)
						BEGIN
							-- start a conversation with the next service in the process
							DECLARE @NextConversationHandle uniqueidentifier = NULL,
								@TargetBatchXml xml = CAST(@thisMessageBody AS xml);
							EXEC [Controller].[SendMessage]
								@ConversationHandle = @NextConversationHandle OUTPUT,
								@InitiatorServiceName = @thisServiceName,
								@TargetServiceName = @TargetServiceName,
								@ContractName = @TargetContractName,
								@MessageType = @TargetMessageType,
								@MessageBody = @TargetBatchXml;

							-- log it
							EXEC [Controller].[LogEvent] @ApplicationName = @ApplicationName, @ServiceName = @thisServiceName, @ConversationHandle = @thisConversationHandle
								,@EventType = @TargetEventType, @EventStatus = 'Succeeded', @EventDetails = @TargetBatchXml;
						END
				END
			ELSE IF (@thisMessageType = N'http://schemas.microsoft.com/SQL/ServiceBroker/EndDialog')
				BEGIN
					-- the target has ended the conversation, so we're done
					END CONVERSATION @thisConversationHandle;
					PRINT N'Message {' + CAST(@thisConversationHandle AS nchar(36)) + N'} conversation ended';
				END
			ELSE
				BEGIN
					-- Ignore the message
					PRINT N'Message {' + CAST(@thisConversationHandle AS nchar(36)) + N'} ignored due to invalid type';
				END
		END
END;

