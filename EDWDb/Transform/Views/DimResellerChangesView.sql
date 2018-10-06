
CREATE VIEW [Transform].[DimResellerChangesView]
AS
WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey' AS ss)
	,PhonePriority_CTE
AS (
	SELECT [ContactTypeID]
		,CASE [Name]
			WHEN 'Owner'
				THEN 1
			WHEN 'Purchasing Manager'
				THEN 2
			WHEN 'Purchasing Agent'
				THEN 3

			ELSE 99
			END AS 'ContactTypeSortOrder'
	FROM [$(EDWStagingSnapshotDb)].[Person].[ContactType]
	)
	,RankedPhoneNumbers_CTE
AS (
	SELECT [BusinessEntityID]
		,[PersonID]
		,[Contact].[ContactTypeID]
		,[rowguid]
		,[ModifiedDate]
		,[PhoneOrder].[ContactTypeSortOrder]
		,RANK() OVER (PARTITION BY [BusinessEntityID] ORDER BY [PhoneOrder].[ContactTypeSortOrder] ASC) AS RANK
	FROM [$(EDWStagingSnapshotDb)].[Person].[BusinessEntityContact] Contact
	INNER JOIN PhonePriority_CTE PhoneOrder
		ON ([Contact].[ContactTypeID] = [PhoneOrder].[ContactTypeID])
	)
SELECT ISNULL([ResellerAddress].[City],'Unknown') COLLATE Latin1_General_CI_AS AS 'ResellerCity'
	,[StateProvince].[StateProvinceCode]  COLLATE Latin1_General_CI_AS AS 'ResellerStateProvinceCode'
	,[StateProvince].[Name]  COLLATE Latin1_General_CI_AS AS 'ResellerStateProvinceName'
	,[Country].[CountryRegionCode]  COLLATE Latin1_General_CI_AS AS 'ResellerCountryRegionCode'
	,[Country].[Name] AS 'ResellerCountryRegionName'
	,[ResellerAddress].[PostalCode]  COLLATE Latin1_General_CI_AS AS 'ResellerPostalCode'
	,[Territory].[Name]  COLLATE Latin1_General_CI_AS AS 'ResellerSalesTerritoryRegion'
	,[Territory].[Group]  COLLATE Latin1_General_CI_AS AS 'ResellerSalesTerritoryGroup'
	,CONCAT ('AW',SUBSTRING(CONVERT(VARCHAR(9), 100000000 + [Store].[BusinessEntityID]), 2, 8))  COLLATE Latin1_General_CI_AS AS 'ResellerID'
	,[Phone].[PhoneNumber]  COLLATE Latin1_General_CI_AS AS 'ResellerPhone'
	,CASE [Store].[Demographics].value('(/ss:StoreSurvey/ss:BusinessType)[1]', 'NVARCHAR(50)')
		WHEN 'BM'
			THEN 'Value Added Reseller'
		WHEN 'BS'
			THEN 'Specialty Bike Shop'
		WHEN 'OS'
			THEN 'Warehouse'
		ELSE [Store].[Demographics].value('(/ss:StoreSurvey/ss:BusinessType)[1]', 'NVARCHAR(50)')
		END  COLLATE Latin1_General_CI_AS AS 'ResellerBusinessType'
	,[Store].[Name]  COLLATE Latin1_General_CI_AS AS 'ResellerResellerName'
	,[Store].[Demographics].value('(/ss:StoreSurvey/ss:NumberEmployees)[1]', 'INT')  AS 'ResellerNumberEmployees'
	,[OrderStats].[OrderFrequency]  COLLATE Latin1_General_CI_AS AS 'ResellerOrderFrequency'
	,CONVERT(INT,[OrderStats].[OrderMonth]) AS 'ResellerOrderMonth'
	,[OrderStats].[FirstOrderYear]  AS 'ResellerFirstOrderYear'
	,[OrderStats].[LastOrderYear]  AS 'ResellerLastOrderYear'
	,[Store].[Demographics].value('(/ss:StoreSurvey/ss:Specialty)[1]', 'NVARCHAR(50)')  AS 'ResellerProductLine'
	,[ResellerAddress].[AddressLine1]  COLLATE Latin1_General_CI_AS AS 'ResellerAddressLine1'
	,[ResellerAddress].[AddressLine2]  COLLATE Latin1_General_CI_AS AS 'ResellerAddressLine2'
	,[Store].[Demographics].value('(/ss:StoreSurvey/ss:AnnualSales)[1]', 'DECIMAL (18,2)')  AS 'ResellerAnnualSales'
	,[Store].[Demographics].value('(/ss:StoreSurvey/ss:BankName)[1]', 'NVARCHAR(50)') AS 'ResellerBankName'
	,CONVERT(INT,[OrderStats].[MinPaymentType])  AS 'ResellerMinPaymentType'
	,CONVERT(DECIMAL (38,2),[OrderStats].[MinPaymentAmount])  AS 'ResellerMinPaymentAmount'
	,[Store].[Demographics].value('(/ss:StoreSurvey/ss:AnnualRevenue)[1]', 'DECIMAL (18,2)') AS 'ResellerAnnualRevenue'
	,[Store].[Demographics].value('(/ss:StoreSurvey/ss:YearOpened)[1]', 'INT')  AS 'ResellerYearOpened'
FROM [$(EDWStagingSnapshotDb)].[Sales].[Store] Store
INNER JOIN [$(EDWStagingSnapshotDb)].[Sales].[StoreOrderStats] OrderStats
	ON ([Store].[BusinessEntityID] = [OrderStats].[BusinessEntityID])
INNER JOIN [$(EDWStagingSnapshotDb)].[Person].[BusinessEntityAddress] BusinessEntity
	ON ([Store].[BusinessEntityID] = [BusinessEntity].[BusinessEntityID])
INNER JOIN [$(EDWStagingSnapshotDb)].[Person].[Address] ResellerAddress
	ON ([BusinessEntity].[AddressID] = [ResellerAddress].[AddressID])
INNER JOIN [$(EDWStagingSnapshotDb)].[Person].[StateProvince] StateProvince
	ON ([ResellerAddress].[StateProvinceID] = [StateProvince].[StateProvinceID])
INNER JOIN [$(EDWStagingSnapshotDb)].[Person].[CountryRegion] Country
	ON ([StateProvince].[CountryRegionCode] = [Country].[CountryRegionCode])
INNER JOIN [$(EDWStagingSnapshotDb)].[Sales].[SalesTerritory] Territory
	ON ([StateProvince].[TerritoryID] = [Territory].[TerritoryID])
INNER JOIN [$(EDWStagingSnapshotDb)].[Person].[BusinessEntityContact] Contact
	ON ([Store].[BusinessEntityID] = [Contact].[BusinessEntityID])
INNER JOIN [$(EDWStagingSnapshotDb)].[Person].[PersonPhone] Phone
	ON ([Contact].[PersonID] = [Phone].[BusinessEntityID])
CROSS APPLY (
	SELECT TOP 1 [BusinessEntityID]
		,[PersonID]
	FROM RankedPhoneNumbers_CTE
	WHERE [Contact].[BusinessEntityID] = [RankedPhoneNumbers_CTE].[BusinessEntityID]
		AND [Contact].[PersonID] = [RankedPhoneNumbers_CTE].[PersonID]
		AND [RankedPhoneNumbers_CTE].[Rank] = 1
	) RankedContact
WHERE [BusinessEntity].[AddressTypeID] = 3;-- Main Office

