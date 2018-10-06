
CREATE PROCEDURE [Controller].[ReportPublisherStartService](
	@DebugOnly bit = 0
)
AS
BEGIN
	DECLARE @ApplicationName sysname = N'ReportPublisher'
		,@thisServiceName sysname = N'ReportPublisher.Start.Service';

	-- check that the snapshot is online and inline with the EDW day end
	IF NOT EXISTS(
		SELECT * FROM sys.databases
		WHERE ([name] = 'EDWSnapshotDb')
		AND ([state_desc] = 'ONLINE')
	) OR (
		[Controller].[fnGetExecutionState]('ICSSystemDateLoaded') <>
		[Controller].[fnGetExecutionState]('EDWSnapshotSystemDate')
	) 
	--OR 
	--(
	--	[Controller].[fnGetExecutionState]('EDWSnapshotSystemDate') <>
	--	CONVERT(DATE,GETDATE())
	--)
	-- If any of the above conditions are true then exit the sproc
	BEGIN
	    IF @DebugOnly = 1
			PRINT 'Procedure Will Be Skipped';
	RETURN;
    END
   
   -- Proceed with procedure from this point
    IF @DebugOnly = 1
			PRINT 'Procedure Will Proceed';

	DECLARE @ConfigurationXml xml([Controller].[ReportPublisherXmlSchema]);
	EXEC [Controller].[ReportPublisherConfigurationXml]
		@ConfigurationXml OUTPUT;

	IF (@ConfigurationXml IS NULL)
		RETURN;
	ELSE IF (@DebugOnly = 1)
		BEGIN
			SELECT @ConfigurationXml;
		END

	DECLARE @BatchQueueXml xml = @ConfigurationXml;
	DECLARE @SingleBatchXml xml = @BatchQueueXml.query('(//Batch)[1]');

	WHILE(CAST(@SingleBatchXml AS varchar(max)) <> '')
		BEGIN
			IF (@DebugOnly = 1)
				BEGIN
					PRINT CAST(@SingleBatchXml AS nvarchar(max));
				END

			DECLARE @IsBatchReadyForProcessing bit = 0
				,@BatchCode varchar(64) = @SingleBatchXml.value('(/Batch/@Code)[1]','varchar(64)')
				,@ScheduleType varchar(64) = @SingleBatchXml.value('(/Batch/Schedule/@Type)[1]','varchar(64)')
				,@ScheduleEventProcedureName nvarchar(128) = @SingleBatchXml.value('(/Batch/Schedule/@EventProcedureName)[1]','nvarchar(128)');

			IF (@ScheduleType = 'Event')
				BEGIN
					DECLARE @ScheduleEventDate datetime,
						@GetScheduleEventStatement nvarchar(256) = N'EXEC [Controller].[' + @ScheduleEventProcedureName + N'] @ScheduleEventDate OUTPUT';
					EXEC sp_executesql @GetScheduleEventStatement,
						N'@ScheduleEventDate datetime OUTPUT',  @ScheduleEventDate OUTPUT;

					DECLARE @ScheduleEventDateString char(19) = CONVERT(char(19),@ScheduleEventDate,120);
					IF (@ScheduleEventDate IS NOT NULL) -- the event has occurred
					AND NOT EXISTS (
						SELECT *
						FROM [Controller].[ServiceEventLog]
						WHERE  ([ApplicationName] = @ApplicationName)
							AND([ServiceName] = @thisServiceName)
							AND([EventType] = 'Controller.Queued')
							AND([EventDetails].exist('//Batch[@Code = sql:variable("@BatchCode")]') = 1)
							AND([EventDetails].exist('//Batch[@ScheduleEventDate = sql:variable("@ScheduleEventDate")]') = 1)
					)
						SET @IsBatchReadyForProcessing = 1;
				END

			IF (@IsBatchReadyForProcessing = 1)
				BEGIN
					-- stamp the batch xml with the schedule event date so that it is not processed twice
					-- this is also used to identify an instance of a batch
					SET @SingleBatchXml.modify('insert attribute ScheduleEventDate {sql:variable("@ScheduleEventDate")} into (/Batch)[1]');

					-- send batch message to queue
					DECLARE @ConversationHandle uniqueidentifier = NULL;

					EXEC [Controller].[SendMessage]
						@ConversationHandle = @ConversationHandle OUTPUT,
						@InitiatorServiceName = @thisServiceName,
						@TargetServiceName = N'ReportPublisher.Controller.Service',
						@ContractName = N'//ReportPublisher/Contract/Synchronous',
						@MessageType = N'//ReportPublisher/Message/Start',
						@MessageBody = @SingleBatchXml;

					EXEC [Controller].[LogEvent] @ApplicationName = @ApplicationName, @ServiceName = @thisServiceName, @ConversationHandle = @ConversationHandle
						,@EventType = 'Controller.Queued', @EventStatus = 'Succeeded', @EventDetails = @SingleBatchXml;

					PRINT N'Message sent to controller queue: ' + CAST(@SingleBatchXml AS nvarchar(max));

					IF(@ConversationHandle IS NOT NULL)
						BEGIN
							-- once we have sent the batch data to the controller service, our work is done
							END CONVERSATION @ConversationHandle;
						END
				END

			SET @BatchQueueXml.modify('delete //Batch[@Code = sql:variable("@BatchCode")]');
			SET @SingleBatchXml = @BatchQueueXml.query('(//Batch)[1]');
		END
END



