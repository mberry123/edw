
CREATE PROCEDURE [Controller].[ReportPublisherGetBatchXml](
	@ConversationHandle uniqueidentifier
	,@BatchXml varchar(max) OUTPUT
)
AS
BEGIN
	DECLARE @RC int = 0
		,@ExceptionMessage nvarchar(2000)
		,@ApplicationName sysname = N'ReportPublisher';

	-- get the batch event details from the service event log
	SELECT @BatchXml = CAST([EventDetails] AS varchar(max))
	FROM [Controller].[ServiceEventLog]
	WHERE  ([ApplicationName] = @ApplicationName)
		AND([ConversationHandle] = @ConversationHandle);

	RETURN(@RC);
END

