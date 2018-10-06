CREATE PROCEDURE [Transform].[GetFactResellerSalesChangedKeys](
	@DebugOnly bit = 0
)
AS
BEGIN
	-- get the version number of the previous transform
	DECLARE @LastTransformedVersion bigint;
	SELECT
		@LastTransformedVersion = NULLIF(CAST([PropertyValue] AS bigint),0)
	FROM [Controller].[ExecutionState]
	WHERE ([PropertyID] = 'FactResellerSalesVersion');

	-- list the dependant tables
	DECLARE @DependantStagingTables table ([TableName] sysname);
	INSERT INTO @DependantStagingTables VALUES
		(N'[Sales].[SalesOrderHeader]'),
		(N'[Sales].[SalesOrderDetail]')
		;

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
				SELECT * FROM [Transform].[FactResellerSalesChangedKeys]
			)
				RETURN(0);

			DECLARE @GetChangesStatement nvarchar(max) = N'
			WITH ChangedKeys AS (
			
				SELECT [Header].[OrderDate]
					,[Header].[SalesOrderID]
					,[Detail].[SalesOrderDetailID]
					,[Header].[RevisionNumber]
				FROM CHANGETABLE(CHANGES [Sales].[SalesOrderHeader], @LastTransformedVersion) Changes
				INNER JOIN [Sales].[SalesOrderHeader] Header
					ON ([Header].[SalesOrderID] = [Changes].[SalesOrderID])
				INNER JOIN [Sales].[SalesOrderDetail] Detail
					ON ([Header].[SalesOrderID] = [Detail].[SalesOrderID])
				INNER JOIN [Sales].[Customer] Customer
					ON ([Header].[CustomerID] = [Customer].[CustomerID])
				WHERE [Customer].[StoreID] IS NOT NULL
				
				UNION

				SELECT [Header].[OrderDate]
					,[Header].[SalesOrderID]
					,[Detail].[SalesOrderDetailID]
					,[Header].[RevisionNumber]
				FROM [Sales].[SalesOrderHeader] Header
				INNER JOIN CHANGETABLE(CHANGES [Sales].[SalesOrderDetail], @LastTransformedVersion) Detail
					ON ([Header].[SalesOrderID] = [Detail].[SalesOrderID])
				INNER JOIN [Sales].[Customer] Customer
					ON ([Header].[CustomerID] = [Customer].[CustomerID])
				WHERE [Customer].[StoreID] IS NOT NULL
			)
			
			SELECT DISTINCT [OrderDate] ,[SalesOrderID], [SalesOrderDetailID], [RevisionNumber] FROM ChangedKeys WHERE [SalesOrderID] IS NOT NULL';

			


			INSERT INTO [Transform].[FactResellerSalesChangedKeys]([OrderDate] ,[SalesOrderID], [SalesOrderDetailID], [RevisionNumber])
			EXEC [$(EDWStagingSnapshotDb)].dbo.sp_executesql
				@GetChangesStatement,
				N'@LastTransformedVersion bigint',
				@LastTransformedVersion;
		END
	ELSE
		BEGIN
			TRUNCATE TABLE [Transform].[FactResellerSalesChangedKeys];

			-- for first time sync, get all keys
			INSERT INTO [Transform].[FactResellerSalesChangedKeys]([OrderDate] ,[SalesOrderID], [SalesOrderDetailID], [RevisionNumber])
			SELECT [Header].[OrderDate]
				  ,[Header].[SalesOrderID]
				  ,[Detail].[SalesOrderDetailID]
				  ,[Header].[RevisionNumber]
			  FROM [$(EDWStagingSnapshotDb)].[Sales].[SalesOrderHeader] Header
			  INNER JOIN [$(EDWStagingSnapshotDb)].[Sales].[SalesOrderDetail] Detail
				ON ([Header].[SalesOrderID] = [Detail].[SalesOrderID])
			  INNER JOIN [$(EDWStagingSnapshotDb)].[Sales].[Customer] Customer
					ON ([Header].[CustomerID] = [Customer].[CustomerID])
			  WHERE [Customer].[StoreID] IS NOT NULL
		END

	-- save the version number for the next transform
	UPDATE [Controller].[ExecutionState]
	SET [PropertyValue] = CAST(@NextTransfomVersion AS varchar(256))
	WHERE ([PropertyID] = 'FactResellerSalesVersion');

	RETURN(0);
END

