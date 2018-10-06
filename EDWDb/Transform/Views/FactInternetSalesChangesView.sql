CREATE VIEW [Transform].[FactInternetSalesChangesView]
AS
WITH SalesOrderLineNo_CTE
AS (
	SELECT [SalesOrderID]
		,[SalesOrderDetailID]
		,RANK() OVER (
			PARTITION BY [SalesOrderID] ORDER BY [SalesOrderDetailID]
			) AS 'InternetSalesOrderLineNumber'
	FROM [$(EDWStagingSnapshotDb)].[Sales].[SalesOrderDetail]
	)
SELECT DISTINCT CONVERT(DATE, [SalesHeader].[OrderDate]) AS 'PartitionKey'
	,[Product].[ProductNumber] COLLATE Latin1_General_CI_AS AS 'ProductKey_ProductCode'
	,CONVERT(DATE, [SalesHeader].[OrderDate]) AS 'OrderDateKey_FullDate'
	,CONVERT(DATE, [SalesHeader].[DueDate]) AS 'DueDateKey_FullDate'
	,CONVERT(DATE, [SalesHeader].[ShipDate]) AS 'ShipDateKey_FullDate'
	,[Customer].[AccountNumber] AS 'CustomerKey_CustomerID'
	,[SalesDetails].[SpecialOfferID] AS 'PromotionKey_PromotionID'
	,[Currency].CurrencyCode COLLATE Latin1_General_CI_AS AS 'CurrencyKey_DescriptionCode'
	,'Currency' AS 'CurrencyKey_DescriptionTypeCode'
	,[Customer].[TerritoryID] AS 'SalesTerritoryKey_SalesTerritoryID'
	,[SalesHeader].[SalesOrderID] AS 'InternetSalesOrderNumber'
	,[LineNumber].[InternetSalesOrderLineNumber]
	,[SalesHeader].[RevisionNumber] AS 'InternetSalesRevisionNumber'
	,[SalesDetails].[OrderQty] AS 'InternetSalesOrderQuantity'
	,[SalesDetails].[UnitPrice] AS 'InternetSalesUnitPrice'
	,[SalesDetails].[OrderQty] * [SalesDetails].[UnitPrice] AS 'InternetSalesExtendedAmount'
	,[SalesDetails].[UnitPriceDiscount] AS 'InternetSalesUnitPriceDiscountPercentage'
	,([SalesDetails].[OrderQty] * [SalesDetails].[UnitPrice]) * [SalesDetails].[UnitPriceDiscount] AS 'InternetSalesDiscountAmount'
	,[Product].[StandardCost] AS 'InternetSalesUnitProductStandardCost'
	,[SalesDetails].[OrderQty] * [Product].[StandardCost] AS 'InternetSalesTotalProductCost'
	,CONVERT(DECIMAL(18, 4), [SalesDetails].[LineTotal]) AS 'InternetSalesAmount'
	,CONVERT(DECIMAL(18, 4), [SalesDetails].[LineTotal] + ([SalesDetails].[LineTotal] * (([SalesHeader].[TaxAmt] / [SalesHeader].[TotalDue]) * 100)) / 100 - [SalesDetails].[LineTotal]) AS 'InternetSalesTaxAmount'
	,CONVERT(DECIMAL(18, 4), [SalesDetails].[LineTotal] + ([SalesDetails].[LineTotal] * (([SalesHeader].[Freight] / [SalesHeader].[TotalDue]) * 100)) / 100 - [SalesDetails].[LineTotal]) AS 'InternetSalesFreightAmount'
	,[SalesDetails].[CarrierTrackingNumber] COLLATE Latin1_General_CI_AS AS 'CarrierTrackingNumber'
	,[SalesHeader].[PurchaseOrderNumber] COLLATE Latin1_General_CI_AS AS 'PurchaseOrderNumber'
	,[SalesHeader].[OrderDate]
	,[SalesHeader].[DueDate]
	,[SalesHeader].[ShipDate]
FROM [$(EDWStagingSnapshotDb)].[Sales].[SalesOrderHeader] SalesHeader
INNER JOIN [$(EDWStagingSnapshotDb)].[Sales].[SalesOrderDetail] SalesDetails
	ON ([SalesHeader].[SalesOrderID] = [SalesDetails].[SalesOrderID])
INNER JOIN [Transform].[FactInternetSalesChangedKeys] ChangedKeys
	ON ([SalesHeader].[SalesOrderID] = [ChangedKeys].[SalesOrderID]
	AND [SalesHeader].[OrderDate] = [ChangedKeys].[OrderDate]
	AND [SalesDetails].[SalesOrderDetailID] = [ChangedKeys].[SalesOrderDetailID]
	AND [SalesHeader].[RevisionNumber] = [ChangedKeys].[RevisionNumber])
INNER JOIN [$(EDWStagingSnapshotDb)].[Sales].[Customer] Customer
	ON ([SalesHeader].[CustomerID] = [Customer].[CustomerID])
INNER JOIN [$(EDWStagingSnapshotDb)].[Sales].[SalesTerritory] Territory
	ON ([Customer].[TerritoryID] = [Territory].[TerritoryID])
INNER JOIN [$(EDWStagingSnapshotDb)].[Sales].[CountryRegionCurrency] Currency
	ON ([Territory].[CountryRegionCode] = [Currency].[CountryRegionCode])
INNER JOIN [$(EDWStagingSnapshotDb)].[Production].[Product] Product
	ON ([SalesDetails].[ProductID] = [Product].[ProductID])
INNER JOIN SalesOrderLineNo_CTE LineNumber
	ON ([SalesDetails].[SalesOrderID] = [LineNumber].[SalesOrderID]
	AND [SalesDetails].[SalesOrderDetailID] = [LineNumber].[SalesOrderDetailID]			)
WHERE [Customer].[StoreID] IS NULL
AND [Currency].[CurrencyCode] NOT IN (
 'ATS'
,'BEF'
,'DEM'
,'ESP'
,'FIM'
,'FRF'
,'GRD'
,'IEP'
,'ITL'
,'NLG'
,'PLZ'
,'PTE'
,'RUR'
)


