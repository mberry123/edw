
CREATE PROCEDURE [Support].[GetStrategyScorecardExceptions](
	@StrategyScorecardExceptionsCount int OUTPUT
)
AS
BEGIN
	DECLARE @BookonLocationPath nvarchar(256) = [Controller].[fnGetConfigurationItem]('StrategyScorecardBookonLocationPath'),
		@RescoreLocationPath nvarchar(256) = [Controller].[fnGetConfigurationItem]('StrategyScorecardRescoreLocationPath');

	SELECT
		@StrategyScorecardExceptionsCount = COUNT(*)
	FROM [Model].[FactCaseRevisions] AS [CurrentRev]
	INNER JOIN [Model].[DimCase] AS [Case]
		ON ([Case].[CaseKey] = [CurrentRev].[CaseKey])
	INNER JOIN [Model].[DimCaseLocation] AS [Location]
		ON ([Location].[CaseLocationKey] = [Case].[CaseLocationKey])
	INNER JOIN [Model].[DimDate] AS [Date]
			ON ([Date].[DateKey] = [CurrentRev].[CaseScoreDateKey])
	INNER JOIN [Model].[DimDescription] AS [Description]
			ON ([Description].[DescriptionKey] = [CurrentRev].[CaseScorecardCategoryKey])
	WHERE  ([CurrentRev].[EndDate] IS NULL) -- latest revision
		AND(
				(
					(
						[Location].[CaseLocationCategoryCode] + '/' +
						[Location].[CaseLocationStrategyCode] + '/' +
						[Location].[CaseLocationQueueCode] = @BookonLocationPath
					)
				AND (COALESCE([CurrentRev].[CasePTCScore], [CurrentRev].[CasePTPScore]) IS NULL) --has no score
				)
				OR (
						(
							[Location].[CaseLocationCategoryCode] + '/' +
							[Location].[CaseLocationStrategyCode] + '/' +
							[Location].[CaseLocationQueueCode] = @RescoreLocationPath
						)
					AND (
							(COALESCE([CurrentRev].[CasePTCScore], [CurrentRev].[CasePTPScore]) IS NULL) --has no score
						OR	([Date].FullDate < (
								SELECT MAX(MovementDate.[FullDate])
								FROM [Model].[FactCaseMovements] AS Movements
								INNER JOIN [Model].[DimDate] AS MovementDate
									ON (MovementDate.[DateKey] = Movements.[MovementDateKey])
								WHERE (Movements.[CaseKey] = CurrentRev.[CaseKey])
							) --has not changed since moving to the queue
						)
					)
				)
			);
	RETURN(0);
END
