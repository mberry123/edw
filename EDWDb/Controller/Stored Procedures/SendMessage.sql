
CREATE PROCEDURE [Controller].[SendMessage](
	@ConversationGroupID uniqueidentifier = NULL,
	@ConversationHandle uniqueidentifier OUTPUT,
	@InitiatorServiceName sysname,
	@TargetServiceName sysname,
	@ContractName sysname = NULL,
	@MessageType sysname,
	@MessageBody xml
)
AS
BEGIN
	IF (@ContractName IS NULL)
		SET @ContractName = REPLACE(@TargetServiceName,N'.Service',N'.Contract');

	IF (@ConversationHandle IS NULL)
		BEGIN
			DECLARE @NewConversationHandle uniqueidentifier;

			-- start conversation
			DECLARE @StartDialogStatement nvarchar(2000) = N'
				BEGIN DIALOG CONVERSATION @NewConversationHandle 
				FROM SERVICE [' + @InitiatorServiceName + N']
				TO SERVICE ''' + @TargetServiceName + N'''
				ON CONTRACT [' + @ContractName + N']
				WITH ENCRYPTION = OFF' +
				(CASE
					WHEN (@ConversationGroupID IS NOT NULL) THEN N',RELATED_CONVERSATION_GROUP = @ConversationGroupID'
					ELSE N''
				END);

			EXEC sp_executesql @StartDialogStatement,
				N'@NewConversationHandle uniqueidentifier OUTPUT, @ConversationGroupID uniqueidentifier',
				@NewConversationHandle OUTPUT, @ConversationGroupID;

			PRINT 'New conversation {' + CAST(@NewConversationHandle AS nchar(36)) + N'} between [' + @InitiatorServiceName + '] and [' + @TargetServiceName + '] started';

			SET @ConversationHandle = @NewConversationHandle;
		END
	ELSE
		BEGIN
			-- keep the same handle
			SET @ConversationHandle = @ConversationHandle;
		END;

	-- send message
	SEND ON CONVERSATION @ConversationHandle  
		MESSAGE TYPE @MessageType (@MessageBody);

	RETURN(0);
END
