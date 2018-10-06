CREATE PROCEDURE [Transform].[GetDimCustomerChangedKeys] (
	@DebugOnly bit = 0
) AS 
BEGIN
	DECLARE @LastTransformedVersion bigint;
	SELECT
		@LastTransformedVersion = NULLIF(CAST([PropertyValue] AS bigint),0)
	FROM [Controller].[ExecutionState]
	WHERE ([PropertyID] = 'DimCustomerVersion');

	-- list the dependant tables
	DECLARE @DependantStagingTables table ([TableName] sysname);
	INSERT INTO @DependantStagingTables VALUES
		(N'[Sales].[Customer]'), 
		(N'[Person].[Person]'), 
		(N'[Person].[BusinessEntityAddress]'), 
		(N'[Person].[Address]'), 
		(N'[Person].[StateProvince]'), 
		(N'[Person].[CountryRegion]'), 
		(N'[Sales].[SalesTerritory]'), 
		(N'[Person].[PersonPhone]'), 
		(N'[Person].[EmailAddress]'), 
		(N'[Person].[BusinessEntityAddress]');
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
				SELECT * FROM [Transform].[DimCustomerChangedKeys]
			)
				RETURN(0);

			DECLARE @GetChangesStatement nvarchar(max) = N'
		WITH ChangedKeys AS 
		(

		SELECT [Customer].[AccountNumber] AS CustomerID
		FROM CHANGETABLE(CHANGES [Sales].[Customer], @LastTransformedVersion) Changes
		INNER JOIN [Sales].[Customer] Customer
			ON ([Changes].[CustomerID] = [Customer].[CustomerID])
		INNER JOIN [Person].[Person] Person
			ON ([Customer].[PersonID] = [Person].[BusinessEntityID])
		INNER JOIN [Person].[BusinessEntityAddress] EntityAddress
			ON ([Person].[BusinessEntityID] = [EntityAddress].BusinessEntityID)
		INNER JOIN [Person].[Address] CustomerAddress
			ON ([EntityAddress].[AddressID] = [CustomerAddress].[AddressID])
		INNER JOIN [Person].[StateProvince] StateProvince
			ON ([CustomerAddress].[StateProvinceID] = [StateProvince].[StateProvinceID])
		INNER JOIN [Person].[CountryRegion] Country
			ON ([StateProvince].[CountryRegionCode] = [Country].[CountryRegionCode])
		INNER JOIN [Sales].[SalesTerritory] Territory
			ON ([StateProvince].[TerritoryID] = [Territory].[TerritoryID])
		INNER JOIN [Person].[PersonPhone] Phone
			ON ([Person].[BusinessEntityID] = [Phone].[BusinessEntityID])
		INNER JOIN [Person].[EmailAddress] Email
			ON ([Person].[BusinessEntityID] = [Email].[BusinessEntityID])
		INNER JOIN [Person].[BusinessEntityAddress] AddressType
			ON ([Person].[BusinessEntityID] = [AddressType].[BusinessEntityID]
				AND [AddressType].[AddressID] = [CustomerAddress].[AddressID])
		WHERE [Customer].[PersonID] IS NOT NULL
			AND [AddressType].[AddressTypeID] = 2

	UNION

		SELECT [Customer].[AccountNumber] AS CustomerID
		FROM [Sales].[Customer] Customer
		INNER JOIN CHANGETABLE(CHANGES [Person].[Person], @LastTransformedVersion) Person
			ON ([Customer].[PersonID] = [Person].[BusinessEntityID])
		INNER JOIN [Person].[BusinessEntityAddress] EntityAddress
			ON ([Person].[BusinessEntityID] = [EntityAddress].BusinessEntityID)
		INNER JOIN [Person].[Address] CustomerAddress
			ON ([EntityAddress].[AddressID] = [CustomerAddress].[AddressID])
		INNER JOIN [Person].[StateProvince] StateProvince
			ON ([CustomerAddress].[StateProvinceID] = [StateProvince].[StateProvinceID])
		INNER JOIN [Person].[CountryRegion] Country
			ON ([StateProvince].[CountryRegionCode] = [Country].[CountryRegionCode])
		INNER JOIN [Sales].[SalesTerritory] Territory
			ON ([StateProvince].[TerritoryID] = [Territory].[TerritoryID])
		INNER JOIN [Person].[PersonPhone] Phone
			ON ([Person].[BusinessEntityID] = [Phone].[BusinessEntityID])
		INNER JOIN [Person].[EmailAddress] Email
			ON ([Person].[BusinessEntityID] = [Email].[BusinessEntityID])
		INNER JOIN [Person].[BusinessEntityAddress] AddressType
			ON ([Person].[BusinessEntityID] = [AddressType].[BusinessEntityID]
				AND [AddressType].[AddressID] = [CustomerAddress].[AddressID])
		WHERE [Customer].[PersonID] IS NOT NULL
			AND [AddressType].[AddressTypeID] = 2


	UNION


		SELECT [Customer].[AccountNumber] AS CustomerID
		FROM [Sales].[Customer] Customer
		INNER JOIN [Person].[Person] Person
			ON ([Customer].[PersonID] = [Person].[BusinessEntityID])
		INNER JOIN CHANGETABLE(CHANGES [Person].[BusinessEntityAddress], @LastTransformedVersion) EntityAddress
			ON ([Person].[BusinessEntityID] = [EntityAddress].BusinessEntityID)
		INNER JOIN [Person].[Address] CustomerAddress
			ON ([EntityAddress].[AddressID] = [CustomerAddress].[AddressID])
		INNER JOIN [Person].[StateProvince] StateProvince
			ON ([CustomerAddress].[StateProvinceID] = [StateProvince].[StateProvinceID])
		INNER JOIN [Person].[CountryRegion] Country
			ON ([StateProvince].[CountryRegionCode] = [Country].[CountryRegionCode])
		INNER JOIN [Sales].[SalesTerritory] Territory
			ON ([StateProvince].[TerritoryID] = [Territory].[TerritoryID])
		INNER JOIN [Person].[PersonPhone] Phone
			ON ([Person].[BusinessEntityID] = [Phone].[BusinessEntityID])
		INNER JOIN [Person].[EmailAddress] Email
			ON ([Person].[BusinessEntityID] = [Email].[BusinessEntityID])
		INNER JOIN [Person].[BusinessEntityAddress] AddressType
			ON ([Person].[BusinessEntityID] = [AddressType].[BusinessEntityID]
				AND [AddressType].[AddressID] = [CustomerAddress].[AddressID])
		WHERE [Customer].[PersonID] IS NOT NULL
			AND [AddressType].[AddressTypeID] = 2

	UNION


		SELECT [Customer].[AccountNumber] AS CustomerID
		FROM [Sales].[Customer] Customer
		INNER JOIN [Person].[Person] Person
			ON ([Customer].[PersonID] = [Person].[BusinessEntityID])
		INNER JOIN [Person].[BusinessEntityAddress] EntityAddress
			ON ([Person].[BusinessEntityID] = [EntityAddress].BusinessEntityID)
		INNER JOIN CHANGETABLE(CHANGES [Person].[Address], @LastTransformedVersion) Changes
			ON ([EntityAddress].[AddressID] = [Changes].[AddressID])
		INNER JOIN [Person].[Address] CustomerAddress
			ON ([EntityAddress].[AddressID] = [CustomerAddress].[AddressID])
		INNER JOIN [Person].[StateProvince] StateProvince
			ON ([CustomerAddress].[StateProvinceID] = [StateProvince].[StateProvinceID])
		INNER JOIN [Person].[CountryRegion] Country
			ON ([StateProvince].[CountryRegionCode] = [Country].[CountryRegionCode])
		INNER JOIN [Sales].[SalesTerritory] Territory
			ON ([StateProvince].[TerritoryID] = [Territory].[TerritoryID])
		INNER JOIN [Person].[PersonPhone] Phone
			ON ([Person].[BusinessEntityID] = [Phone].[BusinessEntityID])
		INNER JOIN [Person].[EmailAddress] Email
			ON ([Person].[BusinessEntityID] = [Email].[BusinessEntityID])
		INNER JOIN [Person].[BusinessEntityAddress] AddressType
			ON ([Person].[BusinessEntityID] = [AddressType].[BusinessEntityID]
				AND [AddressType].[AddressID] = [CustomerAddress].[AddressID])
		WHERE [Customer].[PersonID] IS NOT NULL
			AND [AddressType].[AddressTypeID] = 2

	UNION


		SELECT [Customer].[AccountNumber] AS CustomerID
		FROM [Sales].[Customer] Customer
		INNER JOIN [Person].[Person] Person
			ON ([Customer].[PersonID] = [Person].[BusinessEntityID])
		INNER JOIN [Person].[BusinessEntityAddress] EntityAddress
			ON ([Person].[BusinessEntityID] = [EntityAddress].BusinessEntityID)
		INNER JOIN [Person].[Address] CustomerAddress
			ON ([EntityAddress].[AddressID] = [CustomerAddress].[AddressID])
		INNER JOIN CHANGETABLE(CHANGES [Person].[StateProvince], @LastTransformedVersion)  Changes
			ON ([CustomerAddress].[StateProvinceID] = [Changes].[StateProvinceID])
		INNER JOIN [Person].[StateProvince] StateProvince
			ON ([Changes].[StateProvinceID] = [StateProvince].[StateProvinceID])
		INNER JOIN [Person].[CountryRegion] Country
			ON ([StateProvince].[CountryRegionCode] = [Country].[CountryRegionCode])
		INNER JOIN [Sales].[SalesTerritory] Territory
			ON ([StateProvince].[TerritoryID] = [Territory].[TerritoryID])
		INNER JOIN [Person].[PersonPhone] Phone
			ON ([Person].[BusinessEntityID] = [Phone].[BusinessEntityID])
		INNER JOIN [Person].[EmailAddress] Email
			ON ([Person].[BusinessEntityID] = [Email].[BusinessEntityID])
		INNER JOIN [Person].[BusinessEntityAddress] AddressType
			ON ([Person].[BusinessEntityID] = [AddressType].[BusinessEntityID]
				AND [AddressType].[AddressID] = [CustomerAddress].[AddressID])
		WHERE [Customer].[PersonID] IS NOT NULL
			AND [AddressType].[AddressTypeID] = 2

	UNION

		SELECT [Customer].[AccountNumber] AS CustomerID
		FROM [Sales].[Customer] Customer
		INNER JOIN [Person].[Person] Person
			ON ([Customer].[PersonID] = [Person].[BusinessEntityID])
		INNER JOIN [Person].[BusinessEntityAddress] EntityAddress
			ON ([Person].[BusinessEntityID] = [EntityAddress].BusinessEntityID)
		INNER JOIN [Person].[Address] CustomerAddress
			ON ([EntityAddress].[AddressID] = [CustomerAddress].[AddressID])
		INNER JOIN [Person].[StateProvince] StateProvince
			ON ([CustomerAddress].[StateProvinceID] = [StateProvince].[StateProvinceID])
		INNER JOIN CHANGETABLE(CHANGES [Person].[CountryRegion], @LastTransformedVersion) Country
			ON ([StateProvince].[CountryRegionCode] = [Country].[CountryRegionCode])
		INNER JOIN [Sales].[SalesTerritory] Territory
			ON ([StateProvince].[TerritoryID] = [Territory].[TerritoryID])
		INNER JOIN [Person].[PersonPhone] Phone
			ON ([Person].[BusinessEntityID] = [Phone].[BusinessEntityID])
		INNER JOIN [Person].[EmailAddress] Email
			ON ([Person].[BusinessEntityID] = [Email].[BusinessEntityID])
		INNER JOIN [Person].[BusinessEntityAddress] AddressType
			ON ([Person].[BusinessEntityID] = [AddressType].[BusinessEntityID]
				AND [AddressType].[AddressID] = [CustomerAddress].[AddressID])
		WHERE [Customer].[PersonID] IS NOT NULL
			AND [AddressType].[AddressTypeID] = 2

	UNION


		SELECT [Customer].[AccountNumber] AS CustomerID
		FROM [Sales].[Customer] Customer
		INNER JOIN [Person].[Person] Person
			ON ([Customer].[PersonID] = [Person].[BusinessEntityID])
		INNER JOIN [Person].[BusinessEntityAddress] EntityAddress
			ON ([Person].[BusinessEntityID] = [EntityAddress].BusinessEntityID)
		INNER JOIN [Person].[Address] CustomerAddress
			ON ([EntityAddress].[AddressID] = [CustomerAddress].[AddressID])
		INNER JOIN [Person].[StateProvince] StateProvince
			ON ([CustomerAddress].[StateProvinceID] = [StateProvince].[StateProvinceID])
		INNER JOIN [Person].[CountryRegion] Country
			ON ([StateProvince].[CountryRegionCode] = [Country].[CountryRegionCode])
		INNER JOIN CHANGETABLE(CHANGES [Sales].[SalesTerritory] , @LastTransformedVersion)  Territory
			ON ([StateProvince].[TerritoryID] = [Territory].[TerritoryID])
		INNER JOIN [Person].[PersonPhone] Phone
			ON ([Person].[BusinessEntityID] = [Phone].[BusinessEntityID])
		INNER JOIN [Person].[EmailAddress] Email
			ON ([Person].[BusinessEntityID] = [Email].[BusinessEntityID])
		INNER JOIN [Person].[BusinessEntityAddress] AddressType
			ON ([Person].[BusinessEntityID] = [AddressType].[BusinessEntityID]
				AND [AddressType].[AddressID] = [CustomerAddress].[AddressID])
		WHERE [Customer].[PersonID] IS NOT NULL
			AND [AddressType].[AddressTypeID] = 2

	UNION

 
		SELECT [Customer].[AccountNumber] AS CustomerID
		FROM [Sales].[Customer] Customer
		INNER JOIN [Person].[Person] Person
			ON ([Customer].[PersonID] = [Person].[BusinessEntityID])
		INNER JOIN [Person].[BusinessEntityAddress] EntityAddress
			ON ([Person].[BusinessEntityID] = [EntityAddress].BusinessEntityID)
		INNER JOIN [Person].[Address] CustomerAddress
			ON ([EntityAddress].[AddressID] = [CustomerAddress].[AddressID])
		INNER JOIN [Person].[StateProvince] StateProvince
			ON ([CustomerAddress].[StateProvinceID] = [StateProvince].[StateProvinceID])
		INNER JOIN [Person].[CountryRegion] Country
			ON ([StateProvince].[CountryRegionCode] = [Country].[CountryRegionCode])
		INNER JOIN [Sales].[SalesTerritory] Territory
			ON ([StateProvince].[TerritoryID] = [Territory].[TerritoryID])
		INNER JOIN CHANGETABLE(CHANGES [Person].[PersonPhone] , @LastTransformedVersion) Phone
			ON ([Person].[BusinessEntityID] = [Phone].[BusinessEntityID])
		INNER JOIN [Person].[EmailAddress] Email
			ON ([Person].[BusinessEntityID] = [Email].[BusinessEntityID])
		INNER JOIN [Person].[BusinessEntityAddress] AddressType
			ON ([Person].[BusinessEntityID] = [AddressType].[BusinessEntityID]
				AND [AddressType].[AddressID] = [CustomerAddress].[AddressID])
		WHERE [Customer].[PersonID] IS NOT NULL
			AND [AddressType].[AddressTypeID] = 2

	UNION


		SELECT [Customer].[AccountNumber] AS CustomerID
		FROM [Sales].[Customer] Customer
		INNER JOIN [Person].[Person] Person
			ON ([Customer].[PersonID] = [Person].[BusinessEntityID])
		INNER JOIN [Person].[BusinessEntityAddress] EntityAddress
			ON ([Person].[BusinessEntityID] = [EntityAddress].BusinessEntityID)
		INNER JOIN [Person].[Address] CustomerAddress
			ON ([EntityAddress].[AddressID] = [CustomerAddress].[AddressID])
		INNER JOIN [Person].[StateProvince] StateProvince
			ON ([CustomerAddress].[StateProvinceID] = [StateProvince].[StateProvinceID])
		INNER JOIN [Person].[CountryRegion] Country
			ON ([StateProvince].[CountryRegionCode] = [Country].[CountryRegionCode])
		INNER JOIN [Sales].[SalesTerritory] Territory
			ON ([StateProvince].[TerritoryID] = [Territory].[TerritoryID])
		INNER JOIN [Person].[PersonPhone] Phone
			ON ([Person].[BusinessEntityID] = [Phone].[BusinessEntityID])
		INNER JOIN CHANGETABLE(CHANGES [Person].[EmailAddress] , @LastTransformedVersion) Email
			ON ([Person].[BusinessEntityID] = [Email].[BusinessEntityID])
		INNER JOIN [Person].[BusinessEntityAddress] AddressType
			ON ([Person].[BusinessEntityID] = [AddressType].[BusinessEntityID]
				AND [AddressType].[AddressID] = [CustomerAddress].[AddressID])
		WHERE [Customer].[PersonID] IS NOT NULL
			AND [AddressType].[AddressTypeID] = 2

)
					SELECT DISTINCT [CustomerID] FROM ChangedKeys';


			INSERT INTO [Transform].[DimCustomerChangedKeys]([CustomerID])
			EXEC [$(EDWStagingSnapshotDb)].dbo.sp_executesql
				@GetChangesStatement,
				N'@LastTransformedVersion bigint',
				@LastTransformedVersion;


		END
	ELSE
		BEGIN
			TRUNCATE TABLE [Transform].[DimCustomerChangedKeys];

			-- for first time sync, get all keys
			INSERT INTO [Transform].[DimCustomerChangedKeys]([CustomerID])
				SELECT [Customer].[AccountNumber] AS CustomerID
				FROM [$(EDWStagingSnapshotDb)].[Sales].[Customer] Customer
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
				WHERE [Customer].[PersonID] IS NOT NULL
				AND [AddressType].[AddressTypeID] = 2;
		END

	-- save the version number for the next transform
	UPDATE [Controller].[ExecutionState]
	SET [PropertyValue] = CAST(@NextTransfomVersion AS varchar(256))
	WHERE ([PropertyID] = 'DimCustomerVersion');

	RETURN(0);
END



