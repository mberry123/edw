

CREATE PROCEDURE [Report].[EDWStatusLatestData]
AS

SELECT	 Telephony.ReportingSystem
		,ServiceStatus.ServiceStatus
		,Telephony.CalendarDate + CAST(LatestTelephonyActivity AS DATETIME) AS LatestTelephonyActivity
		,CaseActions.CalendarDate + CAST(LatestCaseActions AS DATETIME) AS LatestCaseActions
FROM
(
		SELECT 'Real Time Data Warehouse' AS ReportingSystem
			,CONVERT(DATETIME,CAST(MAX([CallDateKey]) AS VARCHAR(8)),112) AS CalendarDate
			,MAX(dimtime.Time24) AS LatestTelephonyActivity
		FROM [Model].[FactTelephonyActivity] (NOLOCK) tel
		INNER JOIN [Model].[DimTime] (NOLOCK) dimtime
		ON tel.CallStartTimeKey = dimtime.TimeKey
		WHERE [CallDateKey] = (SELECT MAX(CallDateKey) 
								FROM [Model].[FactTelephonyActivity] (NOLOCK)
								WHERE CallDateKey >= CAST(CONVERT(VARCHAR(8),GETDATE()-4,112) AS INT)
								)
	UNION
		SELECT 'Day End Data Warehouse' AS ReportingSystem
			,CONVERT(DATETIME,CAST(MAX([CallDateKey]) AS VARCHAR(8)),112) AS CalendarDate
			,MAX(dimtime.Time24) AS LatestTelephonyActivity 
		FROM [EDWSnapshotDb].[Model].[FactTelephonyActivity] (NOLOCK) tel
		INNER JOIN [EDWSnapshotDb].[Model].[DimTime] (NOLOCK) dimtime
		ON tel.CallStartTimeKey = dimtime.TimeKey
		WHERE [CallDateKey] = (SELECT MAX(CallDateKey) 
								FROM [EDWSnapshotDb].[Model].[FactTelephonyActivity] (NOLOCK)
								WHERE CallDateKey >= CAST(CONVERT(VARCHAR(8),GETDATE()-4,112) AS INT)
								)
) Telephony
INNER JOIN
(
		SELECT 'Real Time Data Warehouse' AS ReportingSystem
			,CONVERT(DATETIME,CAST(MAX([DateKey]) AS VARCHAR(8)),112) AS CalendarDate
			,MAX(dimtime.Time24) AS LatestCaseActions
		FROM [Model].[FactCaseActions] (NOLOCK) CaseActions
		INNER JOIN [Model].[DimTime] (NOLOCK) dimtime
		ON CaseActions.TimeKey = dimtime.TimeKey
		WHERE [DateKey] = (SELECT MAX(DateKey) 
							FROM [Model].[FactCaseActions] (NOLOCK)
							WHERE DateKey >= CAST(CONVERT(VARCHAR(8),GETDATE()-4,112) AS INT)
							)
	UNION
		SELECT 'Day End Data Warehouse' AS ReportingSystem
			,CONVERT(DATETIME,CAST(MAX([DateKey]) AS VARCHAR(8)),112) AS CalendarDate
			,MAX(dimtime.Time24) AS LatestCaseActions
		FROM [EDWSnapshotDb].[Model].[FactCaseActions] (NOLOCK) CaseActions
		INNER JOIN [EDWSnapshotDb].[Model].[DimTime] (NOLOCK) dimtime
		ON CaseActions.TimeKey = dimtime.TimeKey
		WHERE [DateKey] = (SELECT MAX(DateKey) 
							FROM [EDWSnapshotDb].[Model].[FactCaseActions] (NOLOCK)
							WHERE DateKey >= CAST(CONVERT(VARCHAR(8),GETDATE()-4,112) AS INT)
							)
) CaseActions
ON Telephony.ReportingSystem = CaseActions.ReportingSystem
--AND Telephony.CalendarDate = CaseActions.CalendarDate
INNER JOIN
(
		SELECT 'Real Time Data Warehouse' AS ReportingSystem
				,PropertyValue AS ServiceStatus
		FROM [Controller].[ExecutionState]
		WHERE PropertyID = 'ETLServiceStatus'
	UNION
		SELECT 'Day End Data Warehouse' AS ReportingSystem
				,PropertyValue AS ServiceStatus
		FROM [EDWSnapshotDb].[Controller].[ExecutionState]
		WHERE PropertyID = 'ETLServiceStatus'
) ServiceStatus
ON Telephony.ReportingSystem = ServiceStatus.ReportingSystem
