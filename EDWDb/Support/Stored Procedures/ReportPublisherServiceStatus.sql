
CREATE PROCEDURE [Support].[ReportPublisherServiceStatus](
	@PublishDate date = NULL
	,@ShowDetails bit = 0
	,@ShowQueues bit = 0
	,@BatchName sysname = NULL
)
AS
BEGIN
	DECLARE @RC int = 0;

	IF (@ShowQueues = 1)
		SELECT
		(SELECT COUNT(*)/2 FROM [Controller].[ReportPublisherControllerQueue] WITH(NOLOCK)) AS 'Controller'
		,(SELECT COUNT(*)/2 FROM [Controller].[ReportPublisherRenderQueue] WITH(NOLOCK)) AS 'Render'
		,(SELECT COUNT(*)/2 FROM [Controller].[ReportPublisherConsolidateQueue] WITH(NOLOCK)) AS 'Consolidate'
		,(SELECT COUNT(*)/2 FROM [Controller].[ReportPublisherMoveQueue] WITH(NOLOCK)) AS 'Move'
		,(SELECT COUNT(*)/2 FROM [Controller].[ReportPublisherFailedQueue] WITH(NOLOCK)) AS 'Failed';

	-- by default we filter events by the current date
	IF (@PublishDate IS NULL)
		SET @PublishDate = CAST(GETDATE() AS date);

	DECLARE @ExecutionResults TABLE(
		[EventDateTime] datetime
		,[ScheduleEventDate] datetime
		,[Duration] char(8)
		,[BatchName] sysname
		,[BatchType] sysname
		,[BatchID] char(36)
		,[Task] sysname
		,[EventType] varchar(64)
		,[EventStatus] varchar(128)
		,[Results] varchar(128)
		,[EventDetails] xml
		,[EventKey] int
	)
	INSERT INTO @ExecutionResults
	SELECT
		[EventDateTime]
		,[EventDetails].value('(/Batch/@ScheduleEventDate)[1]','datetime') AS 'ScheduleEventDate'
		,[Transform].[fnGetCharTimeFromSeconds](0) AS 'Duration'
		,[EventDetails].value('(/Batch/@Name)[1]','sysname') AS 'BatchName'
		,[EventDetails].value('(/Batch/@Type)[1]','sysname') AS 'BatchType'
		,[EventDetails].value('(/Batch/@ID)[1]','char(36)') AS 'BatchID'
		,REPLACE(REPLACE([ServiceName],'ReportPublisher.',''),'.Service','') AS 'Task'
		,[EventType]
		,[EventStatus]
		,[EventDetails].value('count(//Report)','varchar(3)') AS 'Results'
		,[EventDetails]
		,[EventKey]
	FROM Controller.ServiceEventLog
	WHERE  ([ApplicationName] = 'ReportPublisher')
		AND([EventDateTime] >= @PublishDate)
		AND([ServiceName] = 'ReportPublisher.Start.Service')

	INSERT INTO @ExecutionResults
	SELECT
		[EventDateTime]
		,[EventDetails].value('(/Batch/@ScheduleEventDate)[1]','datetime') AS 'ScheduleEventDate'
		,[Transform].[fnGetCharTimeFromSeconds](
			DATEDIFF(SECOND, StartEvent.[StartTime], [EventDateTime])
		) AS 'Duration'
		,[EventDetails].value('(/Batch/@Name)[1]','sysname') AS 'BatchName'
		,[EventDetails].value('(/Batch/@Type)[1]','sysname') AS 'BatchType'
		,[EventDetails].value('(/Batch/@ID)[1]','char(36)') AS 'BatchID'
		,REPLACE(REPLACE([ServiceName],'ReportPublisher.',''),'.Service','') AS 'Task'
		,[EventType]
		,[EventStatus]
		,(
			(CASE [EventStatus]
				WHEN 'Succeeded' THEN [EventDetails].value('count(//Report[not(Exception)])','varchar(3)')
				ELSE '0'
			END) + '/' +
			[EventDetails].value('count(//Report)','varchar(3)')
		) AS 'Results'
		,[EventDetails]
		,[EventKey]
	FROM Controller.ServiceEventLog AS ExecutionEvent
	CROSS APPLY(
		SELECT [EventDateTime]
		FROM @ExecutionResults AS StartEvent
		WHERE (StartEvent.[BatchID] = ExecutionEvent.[EventDetails].value('(/Batch/@ID)[1]','char(36)'))
	) AS StartEvent(StartTime)
	WHERE  ([ApplicationName] = 'ReportPublisher')
		AND([EventDateTime] >= @PublishDate)
		AND(
				(([EventType] = 'Executed') AND ([EventStatus] = 'Succeeded'))
			OR  (([EventType] = 'Completed') AND ([EventStatus] = 'Failed'))
			)

	IF (@ShowDetails = 1)
		SELECT
			MIN([EventDateTime]) OVER(PARTITION BY [BatchID]) AS 'Started'
			,[EventDateTime]
			,[ScheduleEventDate]
			,[Duration]
			,[BatchName]
			,[BatchType]
			,[BatchID]
			,[Task]
			,[EventType]
			,[EventStatus]
			,[Results]
			,[EventDetails]
			,[EventKey]
		FROM @ExecutionResults
		WHERE ([BatchName] = ISNULL(@BatchName,[BatchName]))
		ORDER BY
			[Started] DESC
			,[EventDateTime] DESC
			,[BatchName]
			,[EventKey] ASC;
	ELSE
		SELECT
			MAX(CASE WHEN ([Task] = 'Start') THEN [EventDateTime] ELSE NULL END) AS 'Started'
			,[ScheduleEventDate]
			,MAX([Duration]) AS 'Duration'
			,[BatchName]
			,[BatchType]
			,MAX(CASE WHEN ([Task] = 'Start') THEN [Results] ELSE NULL END) AS 'Start'
			,ISNULL(MAX(CASE WHEN ([Task] = 'Render') THEN [Results] ELSE NULL END),'') AS 'Render'
			,ISNULL(MAX(CASE WHEN ([Task] = 'Consolidate') THEN [Results] ELSE NULL END),'') AS 'Consolidate'
			,ISNULL(MAX(CASE WHEN ([Task] = 'Move') THEN [Results] ELSE NULL END),'') AS 'Move'
		FROM @ExecutionResults
		WHERE ([BatchName] = ISNULL(@BatchName,[BatchName]))
		GROUP BY
			[ScheduleEventDate]
			,[BatchName]
			,[BatchType]
		ORDER BY
			[Started] DESC;
END

