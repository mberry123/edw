
CREATE PROCEDURE [Controller].[StrategyScorecardExport]
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @BookonLocationPath nvarchar(256) = [Controller].[fnGetConfigurationItem]('StrategyScorecard.LocationPath.Bookon'),
		@RescoreLocationPathsList nvarchar(256) = [Controller].[fnGetConfigurationItem]('StrategyScorecard.LocationPath.Rescore');

	-- As there can be multiple ICS queues for rescore strategies
	-- the semi-colon separated list category, strategy and queue code paths
	-- converted into a recordset to be used as a filter in the query below
	DECLARE @RescoreLocationPaths TABLE ([Path] nvarchar(256));
	INSERT INTO @RescoreLocationPaths
	EXEC [Controller].[UtilSplitListToRecords] @RescoreLocationPathsList, ';';

	-- Get the scores for cases on the book-on or rescore queues
	SELECT
		'LED' AS 'LED'
		,[CurrentRev].[CaseID] AS 'CaseReference'
		,1 AS '1'
		,[Description].[DescriptionCode] AS 'ScorecardCategory'
		,[CurrentRev].[CasePTCScore] AS 'PTCScore'
		,[CurrentRev].[CasePTPScore] AS 'PTPScore'
		,[Date].FullDate AS 'ScoreDate'
		,0 AS 'Rescore Flag'
	FROM [Model].[FactCaseRevisions] AS [CurrentRev]
	INNER JOIN [Model].[DimCase] AS [Case]
		ON ([Case].[CaseKey] = [CurrentRev].[CaseKey])
	INNER JOIN [Model].[DimCaseLocation] AS [Location]
		ON ([Location].[CaseLocationKey] = [Case].[CaseLocationKey])
	INNER JOIN [Model].[DimDate] AS [Date]
		ON ([Date].[DateKey] = [CurrentRev].[CaseScoreDateKey])
	INNER JOIN [Model].[DimDescription] AS [Description]
		ON ([Description].[DescriptionKey] = [CurrentRev].[CaseScorecardCategoryKey])
	LEFT JOIN @RescoreLocationPaths AS RescoreLocationPaths
		ON (RescoreLocationPaths.[Path] = (
						[Location].[CaseLocationCategoryCode] + '/' +
						[Location].[CaseLocationStrategyCode] + '/' +
						[Location].[CaseLocationQueueCode]
					)
			)
	WHERE  ([CurrentRev].[EndDate] IS NULL) -- is latest revision
		AND([CurrentRev].[CaseScoreDateKey] <> -1) -- has been scored...
		AND([Date].FullDate > CAST(DATEADD(day,-7,GETDATE()) AS date)) -- within the last week
		AND(
				(
					[Location].[CaseLocationCategoryCode] + '/' +
					[Location].[CaseLocationStrategyCode] + '/' +
					[Location].[CaseLocationQueueCode] = @BookonLocationPath
				)
				OR (
					(RescoreLocationPaths.[Path] IS NOT NULL)
				AND ([CurrentRev].[CaseScoreDateKey] >= (
							SELECT MAX(Movements.[MovementDateKey])
							FROM [Model].[FactCaseMovements] AS Movements
							WHERE (Movements.[CaseID] = CurrentRev.[CaseID])
						) -- ensure that the score happened after the last movement	
					)
				)
			);
END
