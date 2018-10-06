
CREATE PROCEDURE [Controller].[GetServiceEventDetails](
	@ConversationHandle uniqueidentifier
	,@EventDetails nvarchar(max) OUTPUT
)
AS
BEGIN
	SELECT @EventDetails = CAST([EventDetails] AS nvarchar(max))
	FROM [Controller].[ServiceEventLog]
	WHERE ([ConversationHandle] = @ConversationHandle)
END
