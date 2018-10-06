CREATE VIEW [Transform].[FactResellerSalesChangesView]
AS
WITH SalesOrderLineNo_CTE
AS (
	SELECT [SalesOrderID]
		,[SalesOrderDetailID]
		,RANK() OVER (
			PARTITION BY [SalesOrderID] ORDER BY [SalesOrderDetailID]
			) AS 'ResellerSalesOrderLineNumber'
	FROM [$(EDWStagingSnapshotDb)].[Sales].[SalesOrderDetail]
	)
SELECT DISTINCT CONVERT(DATE, [SalesHeader].[OrderDate]) AS 'PartitionKey'
	,[Product].[ProductNumber] COLLATE Latin1_General_CI_AS AS 'ProductKey_ProductCode'
	,CONVERT(DATE, [SalesHeader].[OrderDate]) AS 'OrderDateKey_FullDate'
	,CONVERT(DATE, [SalesHeader].[DueDate]) AS 'DueDateKey_FullDate'
	,CONVERT(DATE, [SalesHeader].[ShipDate]) AS 'ShipDateKey_FullDate'
	,CONCAT ('AW',SUBSTRING(CONVERT(VARCHAR(9), 100000000 + [Customer].[StoreID]), 2, 8)) COLLATE Latin1_General_CI_AS AS 'ResellerKey_ResellerID'
	,[SalesHeader].[SalesPersonID] AS 'EmployeeKey_EmployeeCode'
	,[SalesDetails].[SpecialOfferID] AS 'PromotionKey_PromotionID'
	,[Currency].CurrencyCode COLLATE Latin1_General_CI_AS AS 'CurrencyKey_DescriptionCode'
	,'Currency' AS 'CurrencyKey_DescriptionTypeCode'
	,[Customer].[TerritoryID] AS 'SalesTerritoryKey_SalesTerritoryID'
	,[SalesHeader].[SalesOrderID] AS 'ResellerSalesOrderNumber'
	,[LineNumber].[ResellerSalesOrderLineNumber]
	,[SalesHeader].[RevisionNumber] AS 'ResellerSalesRevisionNumber'
	,[SalesDetails].[OrderQty] AS 'ResellerSalesOrderQuantity'
	,[SalesDetails].[UnitPrice] AS 'ResellerSalesUnitPrice'
	,[SalesDetails].[OrderQty] * [SalesDetails].[UnitPrice] AS 'ResellerSalesExtendedAmount'
	,[SalesDetails].[UnitPriceDiscount] AS 'ResellerSalesUnitPriceDiscountPercentage'
	,([SalesDetails].[OrderQty] * [SalesDetails].[UnitPrice]) * [SalesDetails].[UnitPriceDiscount] AS 'ResellerSalesDiscountAmount'
	,[Product].[StandardCost] AS 'ResellerSalesUnitProductStandardCost'
	,[SalesDetails].[OrderQty] * [Product].[StandardCost] AS 'ResellerSalesTotalProductCost'
	,CONVERT(DECIMAL(18, 4), [SalesDetails].[LineTotal]) AS 'ResellerSalesAmount'
	,CONVERT(DECIMAL(18, 4), [SalesDetails].[LineTotal] + ([SalesDetails].[LineTotal] * (([SalesHeader].[TaxAmt] / [SalesHeader].[TotalDue]) * 100)) / 100 - [SalesDetails].[LineTotal]) AS 'ResellerSalesTaxAmount'
	,CONVERT(DECIMAL(18, 4), [SalesDetails].[LineTotal] + ([SalesDetails].[LineTotal] * (([SalesHeader].[Freight] / [SalesHeader].[TotalDue]) * 100)) / 100 - [SalesDetails].[LineTotal]) AS 'ResellerSalesFreightAmount'
	,[SalesDetails].[CarrierTrackingNumber] COLLATE Latin1_General_CI_AS AS 'CarrierTrackingNumber'
	,[SalesHeader].[PurchaseOrderNumber] COLLATE Latin1_General_CI_AS AS 'PurchaseOrderNumber'
	,[SalesHeader].[OrderDate]
	,[SalesHeader].[DueDate]
	,[SalesHeader].[ShipDate]
FROM [$(EDWStagingSnapshotDb)].[Sales].[SalesOrderHeader] SalesHeader
INNER JOIN [$(EDWStagingSnapshotDb)].[Sales].[SalesOrderDetail] SalesDetails
	ON ([SalesHeader].[SalesOrderID] = [SalesDetails].[SalesOrderID])
INNER JOIN [Transform].[FactResellerSalesChangedKeys] ChangedKeys
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
INNER JOIN [$(EDWStagingSnapshotDb)].[Person].[BusinessEntityAddress] BusinessEntity
	ON ([Customer].[StoreID] = [BusinessEntity].[BusinessEntityID])
INNER JOIN [$(EDWStagingSnapshotDb)].[Sales].[Store] Store
	ON ([Customer].[StoreID] = [Store].[BusinessEntityID])
INNER JOIN SalesOrderLineNo_CTE LineNumber
	ON ([SalesDetails].[SalesOrderID] = [LineNumber].[SalesOrderID]
	AND [SalesDetails].[SalesOrderDetailID] = [LineNumber].[SalesOrderDetailID]			)
WHERE [Customer].[StoreID] IS NOT NULL
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
