CREATE FUNCTION [Transform].[fnDimPromotionVersions] ()
RETURNS TABLE
AS
RETURN
(	SELECT
		 [PromotionKey]
		,[PromotionID]
		,[StartDate]
		,[EndDate]
		,ROW_NUMBER() OVER(
			PARTITION BY [PromotionID]
			ORDER BY [StartDate]
		) AS 'Version'
	FROM [Model].[DimPromotion] WITH (NOLOCK)
);
