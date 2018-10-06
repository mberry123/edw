CREATE FUNCTION [Transform].[fnDimSalesTerritoryVersions] ()
RETURNS TABLE
AS
RETURN
(	SELECT
		 [SalesTerritoryKey]
		,[SalesTerritoryID]
		,[StartDate]
		,[EndDate]
		,ROW_NUMBER() OVER(
			PARTITION BY [SalesTerritoryID]
			ORDER BY [StartDate]
		) AS 'Version'
	FROM [Model].[DimSalesTerritory] WITH (NOLOCK)
);

