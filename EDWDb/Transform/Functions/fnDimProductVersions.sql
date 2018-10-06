CREATE FUNCTION [Transform].[fnDimProductVersions] ()
RETURNS TABLE
AS
RETURN
(	SELECT
		 [ProductKey]
		,[ProductCode]
		,[StartDate]
		,[EndDate]
		,ROW_NUMBER() OVER(
			PARTITION BY [ProductCode]
			ORDER BY [StartDate]
		) AS 'Version'
	FROM [Model].[DimProduct] WITH (NOLOCK)
);
