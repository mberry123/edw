CREATE VIEW [Model].[DimSalesTerritoryView]
AS
SELECT [SalesTerritoryKey] AS 'Sales Territory Key'
      ,[StartDate] AS 'Sales Territory Row Creation Date'
      ,[EndDate] AS 'Sales Territory Row Closed Date'
	  ,CASE WHEN [EndDate] IS NULL THEN 1 ELSE 0 END  AS 'Sales Territory Current Row Flag'
      ,[SalesTerritoryId]		AS 'Sales Territory Id'
      ,[SalesTerritoryRegion]	AS 'Sales Territory Region'
      ,[SalesTerritoryCountry]	AS 'Sales Territory Country'
      ,[SalesTerritoryGroup]	AS 'Sales Territory Group'
      ,[SalesTerritoryImage]	AS 'Sales Territory Image'
  FROM [Model].[DimSalesTerritory]
;