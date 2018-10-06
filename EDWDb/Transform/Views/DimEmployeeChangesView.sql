CREATE VIEW [Transform].[DimEmployeeChangesView]
AS
SELECT [Employee].[BusinessEntityID] AS 'EmployeeCode'
	  ,[Department].[Name] AS 'EmployeeDepartment'
	  ,[Department].[GroupName]  AS 'EmployeeDepartmentGroupName'
	  ,[DepartmentHistory].[StartDate] AS 'EmployeeDepartmentStartDate'
	  ,[Person].[Title] COLLATE Latin1_General_CI_AS AS 'EmployeeTitle'
	  ,[Person].[FirstName] AS 'EmployeeFirstName'
	  ,[Person].[MiddleName] AS 'EmployeeMiddleName'
	  ,[Person].[LastName] AS 'EmployeeLastName'
	  ,[Person].[Suffix] COLLATE Latin1_General_CI_AS AS 'EmployeeSuffix'
	  ,[Employee].[JobTitle] COLLATE Latin1_General_CI_AS AS 'EmployeeJobTitle'
	  ,[PersonPhone].[PhoneNumber] AS 'EmployeePhoneNumber'
	  ,[PhoneNumberType].[Name] AS 'EmployeePhoneNumberType'
	  ,[EmailAddress].[EmailAddress] COLLATE Latin1_General_CI_AS AS 'EmployeeEmailAddress'
	  ,[Person].[EmailPromotion] AS 'EmployeeEmailPromotion'
	  ,[PersonAddress].[AddressLine1] COLLATE Latin1_General_CI_AS AS 'EmployeeAddressLine1'
	  ,[PersonAddress].[AddressLine2] COLLATE Latin1_General_CI_AS AS 'EmployeeAddressLine2'
	  ,[PersonAddress].[City] COLLATE Latin1_General_CI_AS AS 'EmployeeCity'
	  ,[StateProvince].[Name] AS 'EmployeeStateProvinceName'
	  ,[PersonAddress].[PostalCode] COLLATE Latin1_General_CI_AS AS 'EmployeePostalCode'
	  ,[CountryRegion].[Name] AS 'EmployeeCountryRegionName'
FROM [$(EDWStagingSnapshotDb)].[HumanResources].[Employee] Employee
INNER JOIN [Transform].[DimEmployeeChangedKeys] Changes
	ON ([Employee].[BusinessEntityID] = [Changes].[EmployeeCode])
INNER JOIN [$(EDWStagingSnapshotDb)].[Person].[Person] Person
	ON [Person].[BusinessEntityID] = [Employee].[BusinessEntityID]
INNER JOIN [$(EDWStagingSnapshotDb)].[Person].[BusinessEntityAddress] BusEntityAdd
	ON [BusEntityAdd].[BusinessEntityID] = [Employee].[BusinessEntityID]
INNER JOIN [$(EDWStagingSnapshotDb)].[Person].[Address] PersonAddress
	ON [PersonAddress].[AddressID] = [BusEntityAdd].[AddressID]
INNER JOIN [$(EDWStagingSnapshotDb)].[Person].[StateProvince] StateProvince
	ON [StateProvince].[StateProvinceID] = [PersonAddress].[StateProvinceID]
INNER JOIN [$(EDWStagingSnapshotDb)].[Person].[CountryRegion] CountryRegion
	ON [CountryRegion].[CountryRegionCode] = [StateProvince].[CountryRegionCode]
LEFT OUTER JOIN [$(EDWStagingSnapshotDb)].[Person].[PersonPhone] PersonPhone
	ON [PersonPhone].BusinessEntityID = [Person].[BusinessEntityID]
LEFT OUTER JOIN [$(EDWStagingSnapshotDb)].[Person].[PhoneNumberType] PhoneNumberType
	ON [PersonPhone].[PhoneNumberTypeID] = [PhoneNumberType].[PhoneNumberTypeID]
LEFT OUTER JOIN [$(EDWStagingSnapshotDb)].[Person].[EmailAddress] EmailAddress
	ON [Person].[BusinessEntityID] = [EmailAddress].[BusinessEntityID]
INNER JOIN [$(EDWStagingSnapshotDb)].[HumanResources].[EmployeeDepartmentHistory] DepartmentHistory
	ON [Employee].[BusinessEntityID] = [DepartmentHistory].[BusinessEntityID]
INNER JOIN [$(EDWStagingSnapshotDb)].[HumanResources].[Department] Department
	ON [DepartmentHistory].[DepartmentID] = [Department].[DepartmentID]
WHERE [DepartmentHistory].EndDate IS NULL;


