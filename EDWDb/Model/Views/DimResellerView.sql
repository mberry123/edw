--DROP VIEW [Model].[DimResellerView]

CREATE VIEW [Model].[DimResellerView]
AS
SELECT [ResellerKey]					AS 'Reseller Key'
	,[StartDate]						AS 'Reseller Row Creation Date'
	,[EndDate]							AS 'Reseller Row Closed Date'
	,CASE 
		WHEN [EndDate] IS NULL
			THEN 1
		ELSE 0
		END								AS 'Reseller Current Row Flag'
	,[ResellerCity]						AS 'Reseller City'
	,[ResellerStateProvinceCode]		AS 'Reseller State Province Code'
	,[ResellerStateProvinceName]		AS 'Reseller State Province Name'
	,[ResellerCountryRegionCode]		AS 'Reseller Country Region Code'
	,[ResellerCountryRegionName]		AS 'Reseller Country Region Name'
	,[ResellerPostalCode]				AS 'Reseller Postal Code'
	,[ResellerSalesTerritoryRegion]		AS 'Reseller Sales Territory Region'
	,[ResellerSalesTerritoryGroup]		AS 'Reseller Sales Territory Group'
	,[ResellerID]						AS 'Reseller ID'
	,[ResellerPhone]					AS 'Reseller Phone'
	,[ResellerBusinessType]				AS 'Reseller Business Type'
	,[ResellerResellerName]				AS 'Reseller Reseller Name'
	,[ResellerNumberEmployees]			AS 'Reseller Number Employees'
	,[ResellerOrderFrequency]			AS 'Reseller Order Frequency'
	,[ResellerOrderMonth]				AS 'Reseller Order Month'
	,[ResellerFirstOrderYear]			AS 'Reseller First Order Year'
	,[ResellerLastOrderYear]			AS 'Reseller Last Order Year'
	,[ResellerProductLine]				AS 'Reseller Product Line'
	,[ResellerAddressLine1]				AS 'Reseller Address Line 1'
	,[ResellerAddressLine2]				AS 'Reseller Address Line 2'
	,[ResellerAnnualSales]				AS 'Reseller Annual Sales'
	,[ResellerBankName]					AS 'Reseller Bank Name'
	,[ResellerMinPaymentType]			AS 'Reseller Min Payment Type'
	,[ResellerMinPaymentAmount]			AS 'Reseller Min Payment Amount'
	,[ResellerAnnualRevenue]			AS 'Reseller Annual Revenue'
	,[ResellerYearOpened]				AS 'Reseller Year Opened'
FROM [Model].[DimReseller];

