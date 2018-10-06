
CREATE PROCEDURE [Controller].[ReportPublisherProcessControllerChildQueue](
	@QueueID nvarchar(64)
)
AS
BEGIN
	DECLARE
		@ApplicationName sysname = N'ReportPublisher',
		@QueueName sysname = '[Controller].[ReportPublisher' + @QueueID + 'Queue]',
		@ConversationGroupID uniqueidentifier,
		@ConversationHandle uniqueidentifier,
		@ServiceName sysname,
		@ContractName sysname,
		@MessageType sysname,
		@MessageBody varbinary(MAX);

	WHILE (1 = 1)
		BEGIN
			SET @ConversationHandle = NULL;

			DECLARE @ReceiveQuery nvarchar(512) = N'
			RECEIVE TOP(1)  
				@ConversationGroupID = [conversation_group_id]
				,@ConversationHandle = [conversation_handle]
				,@ServiceName = [service_name]
				,@ContractName = [service_contract_name]
				,@MessageType = [message_type_name] 
				,@MessageBody = [message_body] 
			FROM ' + @QueueName;

			EXEC sp_executesql @ReceiveQuery,
				N'@ConversationGroupID uniqueidentifier OUTPUT
				,@ConversationHandle uniqueidentifier OUTPUT
				,@ServiceName sysname OUTPUT
				,@ContractName sysname OUTPUT
				,@MessageType sysname OUTPUT
				,@MessageBody varbinary(MAX) OUTPUT'
				,@ConversationGroupID OUTPUT
				,@ConversationHandle OUTPUT
				,@ServiceName OUTPUT
				,@ContractName OUTPUT
				,@MessageType OUTPUT
				,@MessageBody OUTPUT;

			IF (@ConversationHandle IS NULL)
				BEGIN
					BREAK;
				END
			ELSE IF (@MessageType = N'//ReportPublisher/Message/Start')
				BEGIN
					-- get file info...
					DECLARE @BatchXml xml = CAST(@MessageBody AS xml);

					BEGIN TRY
						-- stamp the file xml with the conversation handle (for retry purposes)
						SET @BatchXml.modify('replace value of (/File/@ConversationHandle)[1] with sql:variable("@ConversationHandle")');

						-- log start
						EXEC [Controller].[LogEvent] @ApplicationName = @ApplicationName, @ServiceName = @ServiceName, @ConversationHandle = @ConversationHandle
							,@EventType = 'Started', @EventStatus = 'Succeeded', @EventDetails = @BatchXml;

						-- start the SSIS package that is mapped to the queue
						EXEC [Controller].[ReportPublisherExecuteMappedPackage] @QueueID, @ConversationHandle;
					END TRY
					BEGIN CATCH
						-- ok it flunked, lets add exception details to the report xml
						DECLARE @ExceptionMessage xml = [Controller].[GetErrorXml]();

						-- ok, who sent the message?
						DECLARE @InitiatorServiceName sysname = (
							SELECT CAST(sysinfo.[far_service] AS nvarchar(128))
							FROM sys.conversation_endpoints AS sysinfo
							WHERE (sysinfo.[conversation_handle] = @ConversationHandle)
						);

						-- put the details in the exception...tsk, tsk!
						SET @BatchXml.modify('insert sql:variable("@ExceptionMessage") into (//Batch)[1]');
						SET @BatchXml.modify('insert attribute InitiatorServiceName {sql:variable("@InitiatorServiceName")} into (//Exception)[1]');
						SET @BatchXml.modify('insert attribute TargetServiceName {sql:variable("@ServiceName")} into (//Exception)[1]');
						SET @BatchXml.modify('insert attribute ContractName {sql:variable("@ContractName")} into (//Exception)[1]');

						-- log it (just in case the package didn't)
						EXEC [Controller].[LogEvent] @ApplicationName = @ApplicationName, @ServiceName = @ServiceName, @ConversationHandle = @ConversationHandle
							,@EventType = 'Completed', @EventStatus = 'Failed', @EventDetails = @BatchXml;

						-- start a new conversation with the exception service
						DECLARE @ExceptionConversationHandle uniqueidentifier = NULL;
						EXEC [Controller].[SendMessage] @ConversationHandle = @ExceptionConversationHandle OUTPUT
							,@InitiatorServiceName = @ServiceName
							,@TargetServiceName = N'ReportPublisher.Exception.Service'
							,@ContractName = N'//ReportPublisher/Contract/Synchronous'
							,@MessageType = N'//ReportPublisher/Message/Start'
							,@MessageBody = @BatchXml;

						END CONVERSATION @ExceptionConversationHandle;
					END CATCH		
				END
			ELSE IF (@MessageType = N'http://schemas.microsoft.com/SQL/ServiceBroker/EndDialog')
				BEGIN
					-- the opposite end-point has ended the conversation, so hang-up
					END CONVERSATION @ConversationHandle;
					PRINT N'Message {' + CAST(@ConversationHandle AS nchar(36)) + N'} conversation ended';
				END
			ELSE
				BEGIN
					-- Ignore the message
					PRINT N'Message {' + CAST(@ConversationHandle AS nchar(36)) + N'} ignored due to invalid type';
				END
		END
END

