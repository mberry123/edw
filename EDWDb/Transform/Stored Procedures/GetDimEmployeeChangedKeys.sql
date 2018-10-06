CREATE PROCEDURE [Transform].[GetDimEmployeeChangedKeys] (
	@DebugOnly bit = 0
) AS 
BEGIN
	DECLARE @LastTransformedVersion bigint;
	SELECT
		@LastTransformedVersion = NULLIF(CAST([PropertyValue] AS bigint),0)
	FROM [Controller].[ExecutionState]
	WHERE ([PropertyID] = 'DimEmployeeVersion');

	-- list the dependant tables
	DECLARE @DependantStagingTables table ([TableName] sysname);
	INSERT INTO @DependantStagingTables VALUES
		(N'[HumanResources].[Employee]'),
		(N'[Person].[Person]'),
		(N'[Person].[BusinessEntityAddress]'),
		(N'[Person].[Address]'),
		(N'[Person].[StateProvince]'),
		(N'[Person].[CountryRegion]'),		
		(N'[Person].[PersonPhone]'),	
		(N'[Person].[PhoneNumberType]'),		
		(N'[Person].[EmailAddress]'),	
		(N'[HumanResources].[EmployeeDepartmentHistory]'),		
		(N'[HumanResources].[Department]');

	IF (@DebugOnly = 1)
		BEGIN
			SELECT [TableName] FROM @DependantStagingTables;
			RETURN;
		END

	DECLARE C_DEPENDANT_TABLES CURSOR FAST_FORWARD FOR(
		SELECT [TableName] FROM @DependantStagingTables
	);
	DECLARE @TableName sysname;
	OPEN C_DEPENDANT_TABLES;
	FETCH NEXT FROM C_DEPENDANT_TABLES INTO @TableName;
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		-- get the min version number for the table
		DECLARE @MinValidVersion bigint;
		DECLARE @GetMinSyncVersionStatement nvarchar(512) = N'SET @MinValidVersion = CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID(''' + @TableName + '''))';
		EXEC [$(EDWStagingSnapshotDb)].dbo.sp_executesql @GetMinSyncVersionStatement,
		N'@MinValidVersion bigint OUTPUT',
		@MinValidVersion OUTPUT;

		-- reset the last transformed version if out of scope
		IF (@LastTransformedVersion < @MinValidVersion)
			SET @LastTransformedVersion = NULL;

		FETCH NEXT FROM C_DEPENDANT_TABLES INTO @TableName;
	END
	CLOSE C_DEPENDANT_TABLES;
	DEALLOCATE C_DEPENDANT_TABLES;
				
	-- get the version number to save
	DECLARE @NextTransfomVersion bigint;
	DECLARE @GetNextTransfomVersionStatement nvarchar(512) = N'SET @NextTransfomVersion = CHANGE_TRACKING_CURRENT_VERSION()';
	EXEC [$(EDWStagingSnapshotDb)].dbo.sp_executesql @GetNextTransfomVersionStatement,
	N'@NextTransfomVersion bigint OUTPUT',
	@NextTransfomVersion OUTPUT;

	IF (@LastTransformedVersion IS NOT NULL)
		BEGIN
			-- check that the load procedure has cleared the changes
			IF EXISTS(
				SELECT * FROM [Transform].[DimEmployeeChangedKeys]
			)
				RETURN(0);

			DECLARE @GetChangesStatement nvarchar(max) = N'
				WITH ChangedKeys AS (

					SELECT [Employee].[BusinessEntityID] AS [EmployeeCode]
					FROM CHANGETABLE(CHANGES [HumanResources].[Employee], @LastTransformedVersion) Employee
					INNER JOIN [Person].[Person] Person
						ON [Person].[BusinessEntityID] = [Employee].[BusinessEntityID]
					INNER JOIN [Person].[BusinessEntityAddress] BusEntityAdd
						ON [BusEntityAdd].[BusinessEntityID] = [Employee].[BusinessEntityID]
					INNER JOIN [Person].[Address] PersonAddress
						ON [PersonAddress].[AddressID] = [BusEntityAdd].[AddressID]
					INNER JOIN [Person].[StateProvince] StateProvince
						ON [StateProvince].[StateProvinceID] = [PersonAddress].[StateProvinceID]
					INNER JOIN [Person].[CountryRegion] CountryRegion
						ON [CountryRegion].[CountryRegionCode] = [StateProvince].[CountryRegionCode]
					LEFT OUTER JOIN [Person].[PersonPhone] PersonPhone
						ON [PersonPhone].BusinessEntityID = [Person].[BusinessEntityID]
					LEFT OUTER JOIN [Person].[PhoneNumberType] PhoneNumberType
						ON [PersonPhone].[PhoneNumberTypeID] = [PhoneNumberType].[PhoneNumberTypeID]
					LEFT OUTER JOIN [Person].[EmailAddress] EmailAddress
						ON [Person].[BusinessEntityID] = [EmailAddress].[BusinessEntityID]
					INNER JOIN [HumanResources].[EmployeeDepartmentHistory] DepartmentHistory
						ON [Employee].[BusinessEntityID] = [DepartmentHistory].[BusinessEntityID]
					INNER JOIN [HumanResources].[Department] Department
						ON [DepartmentHistory].[DepartmentID] = [Department].[DepartmentID]
					WHERE [DepartmentHistory].EndDate IS NULL

					UNION

					SELECT [Employee].[BusinessEntityID] 
					FROM [HumanResources].[Employee] Employee
					INNER JOIN CHANGETABLE(CHANGES [Person].[Person], @LastTransformedVersion) Person
						ON [Person].[BusinessEntityID] = [Employee].[BusinessEntityID]
					INNER JOIN [Person].[BusinessEntityAddress] BusEntityAdd
						ON [BusEntityAdd].[BusinessEntityID] = [Employee].[BusinessEntityID]
					INNER JOIN [Person].[Address] PersonAddress
						ON [PersonAddress].[AddressID] = [BusEntityAdd].[AddressID]
					INNER JOIN [Person].[StateProvince] StateProvince
						ON [StateProvince].[StateProvinceID] = [PersonAddress].[StateProvinceID]
					INNER JOIN [Person].[CountryRegion] CountryRegion
						ON [CountryRegion].[CountryRegionCode] = [StateProvince].[CountryRegionCode]
					LEFT OUTER JOIN [Person].[PersonPhone] PersonPhone
						ON [PersonPhone].BusinessEntityID = [Person].[BusinessEntityID]
					LEFT OUTER JOIN [Person].[PhoneNumberType] PhoneNumberType
						ON [PersonPhone].[PhoneNumberTypeID] = [PhoneNumberType].[PhoneNumberTypeID]
					LEFT OUTER JOIN [Person].[EmailAddress] EmailAddress
						ON [Person].[BusinessEntityID] = [EmailAddress].[BusinessEntityID]
					INNER JOIN [HumanResources].[EmployeeDepartmentHistory] DepartmentHistory
						ON [Employee].[BusinessEntityID] = [DepartmentHistory].[BusinessEntityID]
					INNER JOIN [HumanResources].[Department] Department
						ON [DepartmentHistory].[DepartmentID] = [Department].[DepartmentID]
					WHERE [DepartmentHistory].EndDate IS NULL

					UNION

					SELECT [Employee].[BusinessEntityID] 
					FROM [HumanResources].[Employee] Employee
					INNER JOIN [Person].[Person] Person
						ON [Person].[BusinessEntityID] = [Employee].[BusinessEntityID]
					INNER JOIN CHANGETABLE(CHANGES [Person].[BusinessEntityAddress], @LastTransformedVersion) BusEntityAdd
						ON [BusEntityAdd].[BusinessEntityID] = [Employee].[BusinessEntityID]
					INNER JOIN [Person].[Address] PersonAddress
						ON [PersonAddress].[AddressID] = [BusEntityAdd].[AddressID]
					INNER JOIN [Person].[StateProvince] StateProvince
						ON [StateProvince].[StateProvinceID] = [PersonAddress].[StateProvinceID]
					INNER JOIN [Person].[CountryRegion] CountryRegion
						ON [CountryRegion].[CountryRegionCode] = [StateProvince].[CountryRegionCode]
					LEFT OUTER JOIN [Person].[PersonPhone] PersonPhone
						ON [PersonPhone].BusinessEntityID = [Person].[BusinessEntityID]
					LEFT OUTER JOIN [Person].[PhoneNumberType] PhoneNumberType
						ON [PersonPhone].[PhoneNumberTypeID] = [PhoneNumberType].[PhoneNumberTypeID]
					LEFT OUTER JOIN [Person].[EmailAddress] EmailAddress
						ON [Person].[BusinessEntityID] = [EmailAddress].[BusinessEntityID]
					INNER JOIN [HumanResources].[EmployeeDepartmentHistory] DepartmentHistory
						ON [Employee].[BusinessEntityID] = [DepartmentHistory].[BusinessEntityID]
					INNER JOIN [HumanResources].[Department] Department
						ON [DepartmentHistory].[DepartmentID] = [Department].[DepartmentID]
					WHERE [DepartmentHistory].EndDate IS NULL

					UNION

					SELECT [Employee].[BusinessEntityID] 
					FROM [HumanResources].[Employee] Employee
					INNER JOIN [Person].[Person] Person
						ON [Person].[BusinessEntityID] = [Employee].[BusinessEntityID]
					INNER JOIN [Person].[BusinessEntityAddress] BusEntityAdd
						ON [BusEntityAdd].[BusinessEntityID] = [Employee].[BusinessEntityID]
					INNER JOIN CHANGETABLE(CHANGES [Person].[Address], @LastTransformedVersion) PersonAddressChanges
						ON [PersonAddressChanges].[AddressID] = [BusEntityAdd].[AddressID]
					INNER JOIN [Person].[Address] PersonAddress
						ON [PersonAddress].[AddressID] = [PersonAddressChanges].[AddressID]
					INNER JOIN [Person].[StateProvince] StateProvince
						ON [StateProvince].[StateProvinceID] = [PersonAddress].[StateProvinceID]
					INNER JOIN [Person].[CountryRegion] CountryRegion
						ON [CountryRegion].[CountryRegionCode] = [StateProvince].[CountryRegionCode]
					LEFT OUTER JOIN [Person].[PersonPhone] PersonPhone
						ON [PersonPhone].BusinessEntityID = [Person].[BusinessEntityID]
					LEFT OUTER JOIN [Person].[PhoneNumberType] PhoneNumberType
						ON [PersonPhone].[PhoneNumberTypeID] = [PhoneNumberType].[PhoneNumberTypeID]
					LEFT OUTER JOIN [Person].[EmailAddress] EmailAddress
						ON [Person].[BusinessEntityID] = [EmailAddress].[BusinessEntityID]
					INNER JOIN [HumanResources].[EmployeeDepartmentHistory] DepartmentHistory
						ON [Employee].[BusinessEntityID] = [DepartmentHistory].[BusinessEntityID]
					INNER JOIN [HumanResources].[Department] Department
						ON [DepartmentHistory].[DepartmentID] = [Department].[DepartmentID]
					WHERE [DepartmentHistory].EndDate IS NULL

					UNION

					SELECT [Employee].[BusinessEntityID] 
					FROM [HumanResources].[Employee] Employee
					INNER JOIN [Person].[Person] Person
						ON [Person].[BusinessEntityID] = [Employee].[BusinessEntityID]
					INNER JOIN [Person].[BusinessEntityAddress] BusEntityAdd
						ON [BusEntityAdd].[BusinessEntityID] = [Employee].[BusinessEntityID]
					INNER JOIN [Person].[Address] PersonAddress
						ON [PersonAddress].[AddressID] = [BusEntityAdd].[AddressID]
					INNER JOIN CHANGETABLE(CHANGES [Person].[StateProvince], @LastTransformedVersion) StateProvinceChanges
						ON [StateProvinceChanges].[StateProvinceID] = [PersonAddress].[StateProvinceID]
					INNER JOIN [Person].[StateProvince] StateProvince
						ON [StateProvince].[StateProvinceID] = [StateProvinceChanges].[StateProvinceID]
					INNER JOIN [Person].[CountryRegion] CountryRegion
						ON [CountryRegion].[CountryRegionCode] = [StateProvince].[CountryRegionCode]
					LEFT OUTER JOIN [Person].[PersonPhone] PersonPhone
						ON [PersonPhone].BusinessEntityID = [Person].[BusinessEntityID]
					LEFT OUTER JOIN [Person].[PhoneNumberType] PhoneNumberType
						ON [PersonPhone].[PhoneNumberTypeID] = [PhoneNumberType].[PhoneNumberTypeID]
					LEFT OUTER JOIN [Person].[EmailAddress] EmailAddress
						ON [Person].[BusinessEntityID] = [EmailAddress].[BusinessEntityID]
					INNER JOIN [HumanResources].[EmployeeDepartmentHistory] DepartmentHistory
						ON [Employee].[BusinessEntityID] = [DepartmentHistory].[BusinessEntityID]
					INNER JOIN [HumanResources].[Department] Department
						ON [DepartmentHistory].[DepartmentID] = [Department].[DepartmentID]
					WHERE [DepartmentHistory].EndDate IS NULL


					UNION

					SELECT [Employee].[BusinessEntityID] 
					FROM [HumanResources].[Employee] Employee
					INNER JOIN [Person].[Person] Person
						ON [Person].[BusinessEntityID] = [Employee].[BusinessEntityID]
					INNER JOIN [Person].[BusinessEntityAddress] BusEntityAdd
						ON [BusEntityAdd].[BusinessEntityID] = [Employee].[BusinessEntityID]
					INNER JOIN [Person].[Address] PersonAddress
						ON [PersonAddress].[AddressID] = [BusEntityAdd].[AddressID]
					INNER JOIN [Person].[StateProvince] StateProvince
						ON [StateProvince].[StateProvinceID] = [PersonAddress].[StateProvinceID]
					INNER JOIN CHANGETABLE(CHANGES [Person].[CountryRegion], @LastTransformedVersion) CountryRegion
						ON [CountryRegion].[CountryRegionCode] = [StateProvince].[CountryRegionCode]
					LEFT OUTER JOIN [Person].[PersonPhone] PersonPhone
						ON [PersonPhone].BusinessEntityID = [Person].[BusinessEntityID]
					LEFT OUTER JOIN [Person].[PhoneNumberType] PhoneNumberType
						ON [PersonPhone].[PhoneNumberTypeID] = [PhoneNumberType].[PhoneNumberTypeID]
					LEFT OUTER JOIN [Person].[EmailAddress] EmailAddress
						ON [Person].[BusinessEntityID] = [EmailAddress].[BusinessEntityID]
					INNER JOIN [HumanResources].[EmployeeDepartmentHistory] DepartmentHistory
						ON [Employee].[BusinessEntityID] = [DepartmentHistory].[BusinessEntityID]
					INNER JOIN [HumanResources].[Department] Department
						ON [DepartmentHistory].[DepartmentID] = [Department].[DepartmentID]
					WHERE [DepartmentHistory].EndDate IS NULL

					UNION

					SELECT [Employee].[BusinessEntityID] 
					FROM [HumanResources].[Employee] Employee
					INNER JOIN [Person].[Person] Person
						ON [Person].[BusinessEntityID] = [Employee].[BusinessEntityID]
					INNER JOIN [Person].[BusinessEntityAddress] BusEntityAdd
						ON [BusEntityAdd].[BusinessEntityID] = [Employee].[BusinessEntityID]
					INNER JOIN [Person].[Address] PersonAddress
						ON [PersonAddress].[AddressID] = [BusEntityAdd].[AddressID]
					INNER JOIN [Person].[StateProvince] StateProvince
						ON [StateProvince].[StateProvinceID] = [PersonAddress].[StateProvinceID]
					INNER JOIN [Person].[CountryRegion] CountryRegion
						ON [CountryRegion].[CountryRegionCode] = [StateProvince].[CountryRegionCode]
					INNER JOIN CHANGETABLE(CHANGES [Person].[PersonPhone], @LastTransformedVersion) PersonPhone
						ON [PersonPhone].BusinessEntityID = [Person].[BusinessEntityID]
					LEFT OUTER JOIN [Person].[PhoneNumberType] PhoneNumberType
						ON [PersonPhone].[PhoneNumberTypeID] = [PhoneNumberType].[PhoneNumberTypeID]
					LEFT OUTER JOIN [Person].[EmailAddress] EmailAddress
						ON [Person].[BusinessEntityID] = [EmailAddress].[BusinessEntityID]
					INNER JOIN [HumanResources].[EmployeeDepartmentHistory] DepartmentHistory
						ON [Employee].[BusinessEntityID] = [DepartmentHistory].[BusinessEntityID]
					INNER JOIN [HumanResources].[Department] Department
						ON [DepartmentHistory].[DepartmentID] = [Department].[DepartmentID]
					WHERE [DepartmentHistory].EndDate IS NULL

					UNION

					SELECT [Employee].[BusinessEntityID] 
					FROM [HumanResources].[Employee] Employee
					INNER JOIN [Person].[Person] Person
						ON [Person].[BusinessEntityID] = [Employee].[BusinessEntityID]
					INNER JOIN [Person].[BusinessEntityAddress] BusEntityAdd
						ON [BusEntityAdd].[BusinessEntityID] = [Employee].[BusinessEntityID]
					INNER JOIN [Person].[Address] PersonAddress
						ON [PersonAddress].[AddressID] = [BusEntityAdd].[AddressID]
					INNER JOIN [Person].[StateProvince] StateProvince
						ON [StateProvince].[StateProvinceID] = [PersonAddress].[StateProvinceID]
					INNER JOIN [Person].[CountryRegion] CountryRegion
						ON [CountryRegion].[CountryRegionCode] = [StateProvince].[CountryRegionCode]
					LEFT OUTER JOIN [Person].[PersonPhone] PersonPhone
						ON [PersonPhone].BusinessEntityID = [Person].[BusinessEntityID]
					INNER JOIN CHANGETABLE(CHANGES [Person].[PhoneNumberType], @LastTransformedVersion) PhoneNumberType
						ON [PersonPhone].[PhoneNumberTypeID] = [PhoneNumberType].[PhoneNumberTypeID]
					LEFT OUTER JOIN [Person].[EmailAddress] EmailAddress
						ON [Person].[BusinessEntityID] = [EmailAddress].[BusinessEntityID]
					INNER JOIN [HumanResources].[EmployeeDepartmentHistory] DepartmentHistory
						ON [Employee].[BusinessEntityID] = [DepartmentHistory].[BusinessEntityID]
					INNER JOIN [HumanResources].[Department] Department
						ON [DepartmentHistory].[DepartmentID] = [Department].[DepartmentID]
					WHERE [DepartmentHistory].EndDate IS NULL

					UNION

					SELECT [Employee].[BusinessEntityID] 
					FROM [HumanResources].[Employee] Employee
					INNER JOIN [Person].[Person] Person
						ON [Person].[BusinessEntityID] = [Employee].[BusinessEntityID]
					INNER JOIN [Person].[BusinessEntityAddress] BusEntityAdd
						ON [BusEntityAdd].[BusinessEntityID] = [Employee].[BusinessEntityID]
					INNER JOIN [Person].[Address] PersonAddress
						ON [PersonAddress].[AddressID] = [BusEntityAdd].[AddressID]
					INNER JOIN [Person].[StateProvince] StateProvince
						ON [StateProvince].[StateProvinceID] = [PersonAddress].[StateProvinceID]
					INNER JOIN [Person].[CountryRegion] CountryRegion
						ON [CountryRegion].[CountryRegionCode] = [StateProvince].[CountryRegionCode]
					LEFT OUTER JOIN [Person].[PersonPhone] PersonPhone
						ON [PersonPhone].BusinessEntityID = [Person].[BusinessEntityID]
					LEFT OUTER JOIN [Person].[PhoneNumberType] PhoneNumberType
						ON [PersonPhone].[PhoneNumberTypeID] = [PhoneNumberType].[PhoneNumberTypeID]
					INNER JOIN CHANGETABLE(CHANGES [Person].[EmailAddress], @LastTransformedVersion) EmailAddress
						ON [Person].[BusinessEntityID] = [EmailAddress].[BusinessEntityID]
					INNER JOIN [HumanResources].[EmployeeDepartmentHistory] DepartmentHistory
						ON [Employee].[BusinessEntityID] = [DepartmentHistory].[BusinessEntityID]
					INNER JOIN [HumanResources].[Department] Department
						ON [DepartmentHistory].[DepartmentID] = [Department].[DepartmentID]
					WHERE [DepartmentHistory].EndDate IS NULL

					UNION

					SELECT [Employee].[BusinessEntityID] 
					FROM [HumanResources].[Employee] Employee
					INNER JOIN [Person].[Person] Person
						ON [Person].[BusinessEntityID] = [Employee].[BusinessEntityID]
					INNER JOIN [Person].[BusinessEntityAddress] BusEntityAdd
						ON [BusEntityAdd].[BusinessEntityID] = [Employee].[BusinessEntityID]
					INNER JOIN [Person].[Address] PersonAddress
						ON [PersonAddress].[AddressID] = [BusEntityAdd].[AddressID]
					INNER JOIN [Person].[StateProvince] StateProvince
						ON [StateProvince].[StateProvinceID] = [PersonAddress].[StateProvinceID]
					INNER JOIN [Person].[CountryRegion] CountryRegion
						ON [CountryRegion].[CountryRegionCode] = [StateProvince].[CountryRegionCode]
					LEFT OUTER JOIN [Person].[PersonPhone] PersonPhone
						ON [PersonPhone].BusinessEntityID = [Person].[BusinessEntityID]
					LEFT OUTER JOIN [Person].[PhoneNumberType] PhoneNumberType
						ON [PersonPhone].[PhoneNumberTypeID] = [PhoneNumberType].[PhoneNumberTypeID]
					LEFT OUTER JOIN [Person].[EmailAddress] EmailAddress
						ON [Person].[BusinessEntityID] = [EmailAddress].[BusinessEntityID]
					INNER JOIN CHANGETABLE(CHANGES [HumanResources].[EmployeeDepartmentHistory], @LastTransformedVersion) DepartmentHistoryChanges
						ON [Employee].[BusinessEntityID] = [DepartmentHistoryChanges].[BusinessEntityID]
					INNER JOIN [HumanResources].[EmployeeDepartmentHistory] DepartmentHistory
						ON [DepartmentHistoryChanges].[BusinessEntityID] = [DepartmentHistory].[BusinessEntityID]
					INNER JOIN [HumanResources].[Department] Department
						ON [DepartmentHistory].[DepartmentID] = [Department].[DepartmentID]
					WHERE [DepartmentHistory].EndDate IS NULL

					UNION

					SELECT [Employee].[BusinessEntityID] 
					FROM [HumanResources].[Employee] Employee
					INNER JOIN [Person].[Person] Person
						ON [Person].[BusinessEntityID] = [Employee].[BusinessEntityID]
					INNER JOIN [Person].[BusinessEntityAddress] BusEntityAdd
						ON [BusEntityAdd].[BusinessEntityID] = [Employee].[BusinessEntityID]
					INNER JOIN [Person].[Address] PersonAddress
						ON [PersonAddress].[AddressID] = [BusEntityAdd].[AddressID]
					INNER JOIN [Person].[StateProvince] StateProvince
						ON [StateProvince].[StateProvinceID] = [PersonAddress].[StateProvinceID]
					INNER JOIN [Person].[CountryRegion] CountryRegion
						ON [CountryRegion].[CountryRegionCode] = [StateProvince].[CountryRegionCode]
					LEFT OUTER JOIN [Person].[PersonPhone] PersonPhone
						ON [PersonPhone].BusinessEntityID = [Person].[BusinessEntityID]
					LEFT OUTER JOIN [Person].[PhoneNumberType] PhoneNumberType
						ON [PersonPhone].[PhoneNumberTypeID] = [PhoneNumberType].[PhoneNumberTypeID]
					LEFT OUTER JOIN [Person].[EmailAddress] EmailAddress
						ON [Person].[BusinessEntityID] = [EmailAddress].[BusinessEntityID]
					INNER JOIN [HumanResources].[EmployeeDepartmentHistory] DepartmentHistory
						ON [Employee].[BusinessEntityID] = [DepartmentHistory].[BusinessEntityID]
					INNER JOIN CHANGETABLE(CHANGES [HumanResources].[Department] , @LastTransformedVersion) Department
						ON [DepartmentHistory].[DepartmentID] = [Department].[DepartmentID]
					WHERE [DepartmentHistory].EndDate IS NULL

					)
					SELECT DISTINCT [EmployeeCode] FROM ChangedKeys';


			INSERT INTO [Transform].[DimEmployeeChangedKeys]([EmployeeCode])
			EXEC [$(EDWStagingSnapshotDb)].dbo.sp_executesql
				@GetChangesStatement,
				N'@LastTransformedVersion bigint',
				@LastTransformedVersion;


		END
	ELSE
		BEGIN
			TRUNCATE TABLE [Transform].[DimEmployeeChangedKeys];

			-- for first time sync, get all keys
			INSERT INTO [Transform].[DimEmployeeChangedKeys]([EmployeeCode])
				SELECT [Employee].[BusinessEntityID] 
				FROM [$(EDWStagingSnapshotDb)].[HumanResources].[Employee] Employee
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
				WHERE [DepartmentHistory].EndDate IS NULL
		END

	-- save the version number for the next transform
	UPDATE [Controller].[ExecutionState]
	SET [PropertyValue] = CAST(@NextTransfomVersion AS varchar(256))
	WHERE ([PropertyID] = 'DimEmployeeVersion');

	RETURN(0);
END


