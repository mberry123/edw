CREATE VIEW [Transform].[DimSalesTerritoryChangesView]
AS
SELECT [Territory].[TerritoryID] AS 'SalesTerritoryID'
	,[Territory].[Name] AS 'SalesTerritoryRegion'
	,[Country].[Name] AS 'SalesTerritoryCountry'
	,[Territory].[Group] AS 'SalesTerritoryGroup'
	,CONVERT([varbinary] (MAX),[TerritoryImage].[SalesTerritoryImage]) AS 'SalesTerritoryImage'
FROM [$(EDWStagingSnapshotDb)].[Sales].[SalesTerritory] Territory
INNER JOIN [$(EDWStagingSnapshotDb)].[Person].[CountryRegion] Country
	ON ([Territory].[CountryRegionCode] = [Country].[CountryRegionCode])
INNER JOIN [$(EDWStagingSnapshotDb)].[Sales].[SalesTerritoryImage] TerritoryImage
	ON ([Territory].[TerritoryID] = [TerritoryImage].[TerritoryID]);


