
CREATE PROCEDURE [Controller].[LogEvent]
(
	@ApplicationName NVARCHAR (128)
	,@ServiceName NVARCHAR (128)
	,@ConversationHandle UNIQUEIDENTIFIER
	,@EventType VARCHAR (64)
	,@EventStatus VARCHAR (64)
	,@EventDetails xml = NULL
)
AS 
BEGIN
	DECLARE @RC INT = 0;

	DECLARE @InvalidParameterErrorNumber INT = 50011,
		@InvalidParameterExceptionMessage nvarchar(2048) = N'';

	--Validate event type
	IF (dbo.fnGetStringInstanceCount('[^.]*((Queued\b)|(Started\b)|(Completed\b)|(Executed\b))',@EventType) <> 1)
		BEGIN 		
			SET @InvalidParameterExceptionMessage = FORMATMESSAGE(@InvalidParameterErrorNumber, '@EventType','*.(Queued|Started|Executed|Completed)');
			THROW @InvalidParameterErrorNumber, @InvalidParameterExceptionMessage, 1;
		END

	--Validate event status
	IF (@EventStatus NOT IN ('Succeeded', 'Failed'))
		BEGIN 		
			SET @InvalidParameterExceptionMessage = FORMATMESSAGE(@InvalidParameterErrorNumber, '@EventStatus','Succeeded, Failed.');
			THROW @InvalidParameterErrorNumber, @InvalidParameterExceptionMessage, 1;
		END

	--validate event details
	IF (@EventStatus = 'Failed' AND @EventDetails IS NULL)
		BEGIN 		
			SET @InvalidParameterExceptionMessage = FORMATMESSAGE(@InvalidParameterErrorNumber, '@EventDetails','Not NULL if the Event Type is "Failed".');
			THROW @InvalidParameterErrorNumber, @InvalidParameterExceptionMessage, 1;
		END

	INSERT INTO [Controller].[ServiceEventLog]
           ([ApplicationName]
		   ,[ServiceName]
		   ,[ConversationHandle]
           ,[EventType]
           ,[EventStatus]
           ,[EventDetails])
     VALUES
           (@ApplicationName
		   ,@ServiceName
		   ,@ConversationHandle
           ,@EventType
           ,@EventStatus
           ,@EventDetails);

	PRINT N'Event sucessfully logged';

	RETURN (@RC); 
END;
