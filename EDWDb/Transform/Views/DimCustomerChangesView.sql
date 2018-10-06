CREATE VIEW [Transform].[DimCustomerChangesView]
AS
WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey' AS cs) 
,Version_CTE
AS
(
SELECT [Customer].[CustomerID]
       ,MAX([Version]) AS 'Version'
FROM [Model].[DimCustomer] Customer
INNER JOIN [Transform].[DimCustomerChangedKeys] AS ChangeKeys 
	ON ([ChangeKeys].[CustomerID] = [Customer].[CustomerID])
GROUP BY [Customer].[CustomerID]
)
SELECT [Customer].[AccountNumber] AS 'CustomerID'
	,[Person].[Title] COLLATE Latin1_General_CI_AS AS 'CustomerTitle'
	,[Person].[FirstName] AS 'CustomerFirstName'
	,[Person].[MiddleName] AS 'CustomerMiddleName'
	,[Person].[LastName] AS 'CustomerLastName'
	,[Person].[Demographics].value('(/cs:IndividualSurvey/cs:BirthDate)[1]', 'DATE') AS 'CustomerDOB'
	,[Person].[Demographics].value('(/cs:IndividualSurvey/cs:MaritalStatus)[1]', 'VARCHAR(1)') AS 'CustomerMaritalStatus'
	,[Person].[Demographics].value('(/cs:IndividualSurvey/cs:Gender)[1]', 'VARCHAR(1)') AS 'CustomerGender'
	,[CustomerAddress].[AddressLine1] COLLATE Latin1_General_CI_AS  AS 'CustomerAddressLine1'
	,[CustomerAddress].[AddressLine2] COLLATE Latin1_General_CI_AS  AS 'CustomerAddressLine2'
	,[CustomerAddress].[City] COLLATE Latin1_General_CI_AS  AS 'CustomerCity'
	,[StateProvince].[StateProvinceCode] COLLATE Latin1_General_CI_AS AS 'CustomerStateProvinceCode'
	,[StateProvince].[Name] COLLATE Latin1_General_CI_AS AS 'CustomerStateProvinceName'
	,[Country].[CountryRegionCode] COLLATE Latin1_General_CI_AS AS 'CustomerCountryRegionCode'
	,[Country].[Name] AS 'CustomerCountryRegionName'
	,[Territory].[Name] COLLATE Latin1_General_CI_AS AS 'CustomerSalesTerritoryName'
	,[Territory].[Group] COLLATE Latin1_General_CI_AS AS 'CustomerSalesTerritoryGroup'
	,[CustomerAddress].[PostalCode] COLLATE Latin1_General_CI_AS  AS 'CustomerPostCode'
	,[Phone].[PhoneNumber]  COLLATE Latin1_General_CI_AS AS 'CustomerPhone'
	,[Email].[EmailAddress] COLLATE Latin1_General_CI_AS  AS 'CustomerEmailAddress'
	,[Person].[Demographics].value('(/cs:IndividualSurvey/cs:YearlyIncome)[1]', 'VARCHAR(64)') AS 'CustomerAnualIncome'
	,[Person].[Demographics].value('(/cs:IndividualSurvey/cs:TotalChildren)[1]', 'INT') AS 'CustomerTotalChildren'
	,[Person].[Demographics].value('(/cs:IndividualSurvey/cs:NumberChildrenAtHome)[1]', 'INT') AS 'CustomerChildrenAtHome'
	,[Person].[Demographics].value('(/cs:IndividualSurvey/cs:Education)[1]', 'VARCHAR(64)') AS 'CustomerEducation'
	,[Person].[Demographics].value('(/cs:IndividualSurvey/cs:Occupation)[1]', 'VARCHAR(64)') AS 'CustomerOccupation'
	,[Person].[Demographics].value('(/cs:IndividualSurvey/cs:HomeOwnerFlag)[1]', 'BIT') AS 'CustomerIsHomeOwner'
	,[Person].[Demographics].value('(/cs:IndividualSurvey/cs:NumberCarsOwned)[1]', 'INT') AS 'CustomerNumberOfVehicles'
	,[Person].[Demographics].value('(/cs:IndividualSurvey/cs:DateFirstPurchase)[1]', 'DATE') AS 'CustomerFirstPurchaseDate'
	,[Person].[Demographics].value('(/cs:IndividualSurvey/cs:CommuteDistance)[1]', 'VARCHAR(64)') AS 'CustomerCommuteDistance'
FROM [$(EDWStagingSnapshotDb)].[Sales].[Customer] Customer
INNER JOIN [Transform].[DimCustomerChangedKeys] ChangedKeys
	ON ([Customer].[AccountNumber] = [ChangedKeys].[CustomerID])
INNER JOIN [$(EDWStagingSnapshotDb)].[Person].[Person] Person
	ON ([Customer].[PersonID] = [Person].[BusinessEntityID])
INNER JOIN [$(EDWStagingSnapshotDb)].[Person].[BusinessEntityAddress] EntityAddress
	ON ([Person].[BusinessEntityID] = [EntityAddress].BusinessEntityID)
INNER JOIN [$(EDWStagingSnapshotDb)].[Person].[Address] CustomerAddress
	ON ([EntityAddress].[AddressID] = [CustomerAddress].[AddressID])
INNER JOIN [$(EDWStagingSnapshotDb)].[Person].[StateProvince] StateProvince
	ON ([CustomerAddress].[StateProvinceID] = [StateProvince].[StateProvinceID])
INNER JOIN [$(EDWStagingSnapshotDb)].[Person].[CountryRegion] Country
	ON ([StateProvince].[CountryRegionCode] = [Country].[CountryRegionCode])
INNER JOIN [$(EDWStagingSnapshotDb)].[Sales].[SalesTerritory] Territory
	ON ([StateProvince].[TerritoryID] = [Territory].[TerritoryID])
INNER JOIN [$(EDWStagingSnapshotDb)].[Person].[PersonPhone] Phone
	ON ([Person].[BusinessEntityID] = [Phone].[BusinessEntityID])
INNER JOIN [$(EDWStagingSnapshotDb)].[Person].[EmailAddress] Email
	ON ([Person].[BusinessEntityID] = [Email].[BusinessEntityID])
INNER JOIN [$(EDWStagingSnapshotDb)].[Person].[BusinessEntityAddress] AddressType
	ON ([Person].[BusinessEntityID] = [AddressType].[BusinessEntityID]
	AND [AddressType].[AddressID] = [CustomerAddress].[AddressID])
LEFT JOIN Version_CTE
    ON ([Version_CTE].[CustomerID] = [Customer].[AccountNumber])
WHERE [Customer].[PersonID] IS NOT NULL
AND [AddressType].[AddressTypeID] = 2;
