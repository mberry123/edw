CREATE PROCEDURE [Transform].[GetDimProductChangedKeys] (
	@DebugOnly bit = 0
) AS 
BEGIN
	DECLARE @LastTransformedVersion bigint;
	SELECT
		@LastTransformedVersion = NULLIF(CAST([PropertyValue] AS bigint),0)
	FROM [Controller].[ExecutionState]
	WHERE ([PropertyID] = 'DimProductVersion');

	-- list the dependant tables
	DECLARE @DependantStagingTables table ([TableName] sysname);
	INSERT INTO @DependantStagingTables VALUES
		(N'[Production].[Product]'),
		(N'[Production].[ProductSubcategory]'),
		(N'[ProductSubCategory].[ProductSubCategoryID]'),
		(N'[Production].[ProductCategory]'),
		(N'[Production].[ProductCostHistory]'),
		(N'[Production].[ProductModel]'),		
		(N'[Production].[ProductProductPhoto]'),	
		(N'[Production].[ProductPhoto]'),		
		(N'[Production].[ProductModelProductDescriptionCulture]'),	
		(N'[Production].[ProductDescription]');		

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
				SELECT * FROM [Transform].[DimProductChangedKeys]
			)
				RETURN(0);

			DECLARE @GetChangesStatement nvarchar(max) = N'
			WITH ChangedKeys
			AS (
				SELECT [Product].[ProductNumber] AS [ProductCode]
				FROM CHANGETABLE(CHANGES [Production].[Product], @LastTransformedVersion) Changes
				INNER JOIN [Production].[Product] Product
					ON ([Product].[ProductID] = [Changes].[ProductID])
				LEFT JOIN [Production].[ProductSubcategory] ProductSubCategory
					ON ([Product].[ProductSubCategoryID] = [ProductSubCategory].[ProductSubCategoryID])
				LEFT JOIN [Production].[ProductCategory] ProductCategory
					ON ([ProductSubCategory].[ProductCategoryID] = [ProductCategory].[ProductCategoryID])
				LEFT JOIN [Production].[ProductCostHistory] Costs
					ON ([Product].[ProductID] = [Costs].[ProductID]
						AND [Costs].[EndDate] IS NULL)
				LEFT JOIN [Production].[ProductModel] Model
					ON ([Product].[ProductModelID] = [Model].[ProductModelID])
				LEFT JOIN [Production].[ProductProductPhoto] PhotosIdentifier
					ON ([Product].[ProductID] = [PhotosIdentifier].[ProductID])
				LEFT JOIN [Production].[ProductPhoto] Photos
					ON ([Photos].[ProductPhotoID] = [PhotosIdentifier].[ProductPhotoID])
				OUTER APPLY (
					SELECT TOP 1 [ProductDescription].[Description]
					FROM [Production].[Product] Product1
					INNER JOIN [Production].[ProductModel] [ProductModel]
						ON [Product1].[ProductModelID] = [ProductModel].[ProductModelID]
					INNER JOIN [Production].[ProductModelProductDescriptionCulture] [ProductModelCulture]
						ON [ProductModel].[ProductModelID] = [ProductModelCulture].[ProductModelID]
					INNER JOIN [Production].[ProductDescription] [ProductDescription]
						ON [ProductModelCulture].[ProductDescriptionID] = [ProductDescription].[ProductDescriptionID]
					WHERE [Product].[ProductID] = [Product1].[ProductID]
					) Descriptions
	
				UNION
	
				SELECT [Product].[ProductNumber] AS [ProductCode]
				FROM [Production].[Product] Product
				INNER JOIN [Production].[ProductSubcategory] ProductSubCategory
					ON ([Product].[ProductSubCategoryID] = [ProductSubCategory].[ProductSubCategoryID])
				INNER JOIN CHANGETABLE(CHANGES [Production].[ProductSubcategory], @LastTransformedVersion) ProductSubCategoryChanges
					ON ([ProductSubCategory].[ProductSubCategoryID] = [ProductSubCategoryChanges].[ProductSubCategoryID])
				LEFT JOIN [Production].[ProductCategory] ProductCategory
					ON ([ProductSubCategory].[ProductCategoryID] = [ProductCategory].[ProductCategoryID])
				LEFT JOIN [Production].[ProductCostHistory] Costs
					ON ([Product].[ProductID] = [Costs].[ProductID]
					AND [Costs].[EndDate] IS NULL)
				LEFT JOIN [Production].[ProductModel] Model
					ON ([Product].[ProductModelID] = [Model].[ProductModelID])
				LEFT JOIN [Production].[ProductProductPhoto] PhotosIdentifier
					ON ([Product].[ProductID] = [PhotosIdentifier].[ProductID])
				LEFT JOIN [Production].[ProductPhoto] Photos
					ON ([Photos].[ProductPhotoID] = [PhotosIdentifier].[ProductPhotoID])
				OUTER APPLY (
					SELECT TOP 1 [ProductDescription].[Description]
					FROM [Production].[Product] Product1
					INNER JOIN [Production].[ProductModel] [ProductModel]
						ON [Product1].[ProductModelID] = [ProductModel].[ProductModelID]
					INNER JOIN [Production].[ProductModelProductDescriptionCulture] [ProductModelCulture]
						ON [ProductModel].[ProductModelID] = [ProductModelCulture].[ProductModelID]
					INNER JOIN [Production].[ProductDescription] [ProductDescription]
						ON [ProductModelCulture].[ProductDescriptionID] = [ProductDescription].[ProductDescriptionID]
					WHERE [Product].[ProductID] = [Product1].[ProductID]
					) Descriptions

				UNION
	
				SELECT [Product].[ProductNumber] AS [ProductCode]
				FROM [Production].[Product] Product
				LEFT JOIN [Production].[ProductSubcategory] ProductSubCategory
					ON ([Product].[ProductSubCategoryID] = [ProductSubCategory].[ProductSubCategoryID])
				LEFT JOIN [Production].[ProductSubcategory] ProductSubCategoryChanges
					ON ([ProductSubCategory].[ProductSubCategoryID] = [ProductSubCategoryChanges].[ProductSubCategoryID])
				INNER JOIN CHANGETABLE(CHANGES [Production].[ProductCategory], @LastTransformedVersion)  ProductCategory
					ON ([ProductSubCategory].[ProductCategoryID] = [ProductCategory].[ProductCategoryID])
				LEFT JOIN [Production].[ProductCostHistory] Costs
					ON ([Product].[ProductID] = [Costs].[ProductID]
					AND [Costs].[EndDate] IS NULL)
				LEFT JOIN [Production].[ProductModel] Model
					ON ([Product].[ProductModelID] = [Model].[ProductModelID])
				LEFT JOIN [Production].[ProductProductPhoto] PhotosIdentifier
					ON ([Product].[ProductID] = [PhotosIdentifier].[ProductID])
				LEFT JOIN [Production].[ProductPhoto] Photos
					ON ([Photos].[ProductPhotoID] = [PhotosIdentifier].[ProductPhotoID])
				OUTER APPLY (
					SELECT TOP 1 [ProductDescription].[Description]
					FROM [Production].[Product] Product1
					INNER JOIN [Production].[ProductModel] [ProductModel]
						ON [Product1].[ProductModelID] = [ProductModel].[ProductModelID]
					INNER JOIN [Production].[ProductModelProductDescriptionCulture] [ProductModelCulture]
						ON [ProductModel].[ProductModelID] = [ProductModelCulture].[ProductModelID]
					INNER JOIN [Production].[ProductDescription] [ProductDescription]
						ON [ProductModelCulture].[ProductDescriptionID] = [ProductDescription].[ProductDescriptionID]
					WHERE [Product].[ProductID] = [Product1].[ProductID]
					) Descriptions

				UNION
	
				SELECT [Product].[ProductNumber] AS [ProductCode]
				FROM [Production].[Product] Product
				LEFT JOIN [Production].[ProductSubcategory] ProductSubCategory
					ON ([Product].[ProductSubCategoryID] = [ProductSubCategory].[ProductSubCategoryID])
				LEFT JOIN [Production].[ProductSubcategory] ProductSubCategoryChanges
					ON ([ProductSubCategory].[ProductSubCategoryID] = [ProductSubCategoryChanges].[ProductSubCategoryID])
				LEFT JOIN [Production].[ProductCategory] ProductCategory
					ON ([ProductSubCategory].[ProductCategoryID] = [ProductCategory].[ProductCategoryID])
				INNER JOIN CHANGETABLE(CHANGES [Production].[ProductCostHistory], @LastTransformedVersion)  CostsChanges
					ON ([Product].[ProductID] = [CostsChanges].[ProductID])
				INNER JOIN [Production].[ProductCostHistory] Costs
					ON ([Product].[ProductID] = [Costs].[ProductID]
					AND [Costs].[EndDate] IS NULL)
				LEFT JOIN [Production].[ProductModel] Model
					ON ([Product].[ProductModelID] = [Model].[ProductModelID])
				LEFT JOIN [Production].[ProductProductPhoto] PhotosIdentifier
					ON ([Product].[ProductID] = [PhotosIdentifier].[ProductID])
				LEFT JOIN [Production].[ProductPhoto] Photos
					ON ([Photos].[ProductPhotoID] = [PhotosIdentifier].[ProductPhotoID])
				OUTER APPLY (
					SELECT TOP 1 [ProductDescription].[Description]
					FROM [Production].[Product] Product1
					INNER JOIN [Production].[ProductModel] [ProductModel]
						ON [Product1].[ProductModelID] = [ProductModel].[ProductModelID]
					INNER JOIN [Production].[ProductModelProductDescriptionCulture] [ProductModelCulture]
						ON [ProductModel].[ProductModelID] = [ProductModelCulture].[ProductModelID]
					INNER JOIN [Production].[ProductDescription] [ProductDescription]
						ON [ProductModelCulture].[ProductDescriptionID] = [ProductDescription].[ProductDescriptionID]
					WHERE [Product].[ProductID] = [Product1].[ProductID]
					) Descriptions

				UNION
	
				SELECT [Product].[ProductNumber] AS [ProductCode]
				FROM [Production].[Product] Product
				LEFT JOIN [Production].[ProductSubcategory] ProductSubCategory
					ON ([Product].[ProductSubCategoryID] = [ProductSubCategory].[ProductSubCategoryID])
				LEFT JOIN [Production].[ProductSubcategory] ProductSubCategoryChanges
					ON ([ProductSubCategory].[ProductSubCategoryID] = [ProductSubCategoryChanges].[ProductSubCategoryID])
				LEFT JOIN [Production].[ProductCategory] ProductCategory
					ON ([ProductSubCategory].[ProductCategoryID] = [ProductCategory].[ProductCategoryID])
				LEFT JOIN [Production].[ProductCostHistory] Costs
					ON ([Product].[ProductID] = [Costs].[ProductID]
					AND [Costs].[EndDate] IS NULL)
				INNER JOIN CHANGETABLE(CHANGES [Production].[ProductModel], @LastTransformedVersion)  Model
					ON ([Product].[ProductModelID] = [Model].[ProductModelID])
				LEFT JOIN [Production].[ProductProductPhoto] PhotosIdentifier
					ON ([Product].[ProductID] = [PhotosIdentifier].[ProductID])
				LEFT JOIN [Production].[ProductPhoto] Photos
					ON ([Photos].[ProductPhotoID] = [PhotosIdentifier].[ProductPhotoID])
				OUTER APPLY (
					SELECT TOP 1 [ProductDescription].[Description]
					FROM [Production].[Product] Product1
					INNER JOIN [Production].[ProductModel] [ProductModel]
						ON [Product1].[ProductModelID] = [ProductModel].[ProductModelID]
					INNER JOIN [Production].[ProductModelProductDescriptionCulture] [ProductModelCulture]
						ON [ProductModel].[ProductModelID] = [ProductModelCulture].[ProductModelID]
					INNER JOIN [Production].[ProductDescription] [ProductDescription]
						ON [ProductModelCulture].[ProductDescriptionID] = [ProductDescription].[ProductDescriptionID]
					WHERE [Product].[ProductID] = [Product1].[ProductID]
					) Descriptions

				UNION
	
				SELECT [Product].[ProductNumber] AS [ProductCode]
				FROM [Production].[Product] Product
				LEFT JOIN [Production].[ProductSubcategory] ProductSubCategory
					ON ([Product].[ProductSubCategoryID] = [ProductSubCategory].[ProductSubCategoryID])
				LEFT JOIN [Production].[ProductSubcategory] ProductSubCategoryChanges
					ON ([ProductSubCategory].[ProductSubCategoryID] = [ProductSubCategoryChanges].[ProductSubCategoryID])
				LEFT JOIN [Production].[ProductCategory] ProductCategory
					ON ([ProductSubCategory].[ProductCategoryID] = [ProductCategory].[ProductCategoryID])
				LEFT JOIN [Production].[ProductCostHistory] Costs
					ON ([Product].[ProductID] = [Costs].[ProductID]
					AND [Costs].[EndDate] IS NULL)
				LEFT JOIN [Production].[ProductModel] Model
					ON ([Product].[ProductModelID] = [Model].[ProductModelID])
				INNER JOIN CHANGETABLE(CHANGES [Production].[ProductProductPhoto], @LastTransformedVersion)  PhotosIdentifier
					ON ([Product].[ProductID] = [PhotosIdentifier].[ProductID])
				LEFT JOIN [Production].[ProductPhoto] Photos
					ON ([Photos].[ProductPhotoID] = [PhotosIdentifier].[ProductPhotoID])
				OUTER APPLY (
					SELECT TOP 1 [ProductDescription].[Description]
					FROM [Production].[Product] Product1
					INNER JOIN [Production].[ProductModel] [ProductModel]
						ON [Product1].[ProductModelID] = [ProductModel].[ProductModelID]
					INNER JOIN [Production].[ProductModelProductDescriptionCulture] [ProductModelCulture]
						ON [ProductModel].[ProductModelID] = [ProductModelCulture].[ProductModelID]
					INNER JOIN [Production].[ProductDescription] [ProductDescription]
						ON [ProductModelCulture].[ProductDescriptionID] = [ProductDescription].[ProductDescriptionID]
					WHERE [Product].[ProductID] = [Product1].[ProductID]
					) Descriptions

				UNION
	
				SELECT [Product].[ProductNumber] AS [ProductCode]
				FROM [Production].[Product] Product
				LEFT JOIN [Production].[ProductSubcategory] ProductSubCategory
					ON ([Product].[ProductSubCategoryID] = [ProductSubCategory].[ProductSubCategoryID])
				LEFT JOIN [Production].[ProductSubcategory] ProductSubCategoryChanges
					ON ([ProductSubCategory].[ProductSubCategoryID] = [ProductSubCategoryChanges].[ProductSubCategoryID])
				LEFT JOIN [Production].[ProductCategory] ProductCategory
					ON ([ProductSubCategory].[ProductCategoryID] = [ProductCategory].[ProductCategoryID])
				LEFT JOIN [Production].[ProductCostHistory] Costs
					ON ([Product].[ProductID] = [Costs].[ProductID]
					AND [Costs].[EndDate] IS NULL)
				LEFT JOIN [Production].[ProductModel] Model
					ON ([Product].[ProductModelID] = [Model].[ProductModelID])
				LEFT JOIN [Production].[ProductProductPhoto] PhotosIdentifier
					ON ([Product].[ProductID] = [PhotosIdentifier].[ProductID])
				INNER JOIN CHANGETABLE(CHANGES [Production].[ProductPhoto], @LastTransformedVersion) Photos
					ON ([Photos].[ProductPhotoID] = [PhotosIdentifier].[ProductPhotoID])
				OUTER APPLY (
					SELECT TOP 1 [ProductDescription].[Description]
					FROM [Production].[Product] Product1
					INNER JOIN [Production].[ProductModel] [ProductModel]
						ON [Product1].[ProductModelID] = [ProductModel].[ProductModelID]
					INNER JOIN [Production].[ProductModelProductDescriptionCulture] [ProductModelCulture]
						ON [ProductModel].[ProductModelID] = [ProductModelCulture].[ProductModelID]
					INNER JOIN [Production].[ProductDescription] [ProductDescription]
						ON [ProductModelCulture].[ProductDescriptionID] = [ProductDescription].[ProductDescriptionID]
					WHERE [Product].[ProductID] = [Product1].[ProductID]
					) Descriptions

				UNION
	
				SELECT [Product].[ProductNumber] AS [ProductCode]
				FROM [Production].[Product] Product
				LEFT JOIN [Production].[ProductSubcategory] ProductSubCategory
					ON ([Product].[ProductSubCategoryID] = [ProductSubCategory].[ProductSubCategoryID])
				LEFT JOIN [Production].[ProductSubcategory] ProductSubCategoryChanges
					ON ([ProductSubCategory].[ProductSubCategoryID] = [ProductSubCategoryChanges].[ProductSubCategoryID])
				LEFT JOIN [Production].[ProductCategory] ProductCategory
					ON ([ProductSubCategory].[ProductCategoryID] = [ProductCategory].[ProductCategoryID])
				LEFT JOIN [Production].[ProductCostHistory] Costs
					ON ([Product].[ProductID] = [Costs].[ProductID]
					AND [Costs].[EndDate] IS NULL)
				LEFT JOIN [Production].[ProductModel] Model
					ON ([Product].[ProductModelID] = [Model].[ProductModelID])
				LEFT JOIN [Production].[ProductProductPhoto] PhotosIdentifier
					ON ([Product].[ProductID] = [PhotosIdentifier].[ProductID])
				LEFT JOIN [Production].[ProductPhoto] Photos
					ON ([Photos].[ProductPhotoID] = [PhotosIdentifier].[ProductPhotoID])
				CROSS APPLY (
					SELECT TOP 1 [ProductDescription].[Description]
					FROM [Production].[Product] Product1
					INNER JOIN [Production].[ProductModel] [ProductModel]
						ON [Product1].[ProductModelID] = [ProductModel].[ProductModelID]
					INNER JOIN CHANGETABLE(CHANGES [Production].[ProductModelProductDescriptionCulture], @LastTransformedVersion) [ProductModelCulture]
						ON [ProductModel].[ProductModelID] = [ProductModelCulture].[ProductModelID]
					INNER JOIN [Production].[ProductDescription] [ProductDescription]
						ON [ProductModelCulture].[ProductDescriptionID] = [ProductDescription].[ProductDescriptionID]
					WHERE [Product].[ProductID] = [Product1].[ProductID]
					) Descriptions

				UNION
	
				SELECT [Product].[ProductNumber] AS [ProductCode]
				FROM [Production].[Product] Product
				LEFT JOIN [Production].[ProductSubcategory] ProductSubCategory
					ON ([Product].[ProductSubCategoryID] = [ProductSubCategory].[ProductSubCategoryID])
				LEFT JOIN [Production].[ProductSubcategory] ProductSubCategoryChanges
					ON ([ProductSubCategory].[ProductSubCategoryID] = [ProductSubCategoryChanges].[ProductSubCategoryID])
				LEFT JOIN [Production].[ProductCategory] ProductCategory
					ON ([ProductSubCategory].[ProductCategoryID] = [ProductCategory].[ProductCategoryID])
				LEFT JOIN [Production].[ProductCostHistory] Costs
					ON ([Product].[ProductID] = [Costs].[ProductID]
					AND [Costs].[EndDate] IS NULL)
				LEFT JOIN [Production].[ProductModel] Model
					ON ([Product].[ProductModelID] = [Model].[ProductModelID])
				LEFT JOIN [Production].[ProductProductPhoto] PhotosIdentifier
					ON ([Product].[ProductID] = [PhotosIdentifier].[ProductID])
				LEFT JOIN [Production].[ProductPhoto] Photos
					ON ([Photos].[ProductPhotoID] = [PhotosIdentifier].[ProductPhotoID])
				CROSS APPLY (
					SELECT TOP 1 [ProductDescription].[Description]
					FROM [Production].[Product] Product1
					INNER JOIN [Production].[ProductModel] [ProductModel]
						ON [Product1].[ProductModelID] = [ProductModel].[ProductModelID]
					INNER JOIN [Production].[ProductModelProductDescriptionCulture] [ProductModelCulture]
						ON [ProductModel].[ProductModelID] = [ProductModelCulture].[ProductModelID]
					INNER JOIN CHANGETABLE(CHANGES [Production].[ProductDescription], @LastTransformedVersion) [ProductDescriptionChanges]
						ON [ProductModelCulture].[ProductDescriptionID] = [ProductDescriptionChanges].[ProductDescriptionID]
					INNER JOIN [Production].[ProductDescription] [ProductDescription]
						ON [ProductDescriptionChanges].[ProductDescriptionID] = [ProductDescription].[ProductDescriptionID]
					WHERE [Product].[ProductID] = [Product1].[ProductID]
					) Descriptions

				)
			SELECT DISTINCT [ProductCode]
			FROM ChangedKeys';


			INSERT INTO [Transform].[DimProductChangedKeys]([ProductCode])
			EXEC [$(EDWStagingSnapshotDb)].dbo.sp_executesql
				@GetChangesStatement,
				N'@LastTransformedVersion bigint',
				@LastTransformedVersion;


		END
	ELSE
		BEGIN
			TRUNCATE TABLE [Transform].[DimProductChangedKeys];

			-- for first time sync, get all keys
			INSERT INTO [Transform].[DimProductChangedKeys]([ProductCode])
				SELECT [Product].[ProductNumber] AS [ProductCode]
				FROM [$(EDWStagingSnapshotDb)].[Production].[Product] Product
				LEFT JOIN [$(EDWStagingSnapshotDb)].[Production].[ProductSubcategory] ProductSubCategory
					ON ([Product].[ProductSubCategoryID] = [ProductSubCategory].[ProductSubCategoryID])
				LEFT JOIN [$(EDWStagingSnapshotDb)].[Production].[ProductSubcategory] ProductSubCategoryChanges
					ON ([ProductSubCategory].[ProductSubCategoryID] = [ProductSubCategoryChanges].[ProductSubCategoryID])
				LEFT JOIN [$(EDWStagingSnapshotDb)].[Production].[ProductCategory] ProductCategory
					ON ([ProductSubCategory].[ProductCategoryID] = [ProductCategory].[ProductCategoryID])
				LEFT JOIN [$(EDWStagingSnapshotDb)].[Production].[ProductCostHistory] Costs
					ON ([Product].[ProductID] = [Costs].[ProductID]
					AND [Costs].[EndDate] IS NULL)
				LEFT JOIN [$(EDWStagingSnapshotDb)].[Production].[ProductModel] Model
					ON ([Product].[ProductModelID] = [Model].[ProductModelID])
				LEFT JOIN [$(EDWStagingSnapshotDb)].[Production].[ProductProductPhoto] PhotosIdentifier
					ON ([Product].[ProductID] = [PhotosIdentifier].[ProductID])
				LEFT JOIN [$(EDWStagingSnapshotDb)].[Production].[ProductPhoto] Photos
					ON ([Photos].[ProductPhotoID] = [PhotosIdentifier].[ProductPhotoID])
				OUTER APPLY (
					SELECT TOP 1 [ProductDescription].[Description]
					FROM [$(EDWStagingSnapshotDb)].[Production].[Product] Product1
					INNER JOIN [$(EDWStagingSnapshotDb)].[Production].[ProductModel] [ProductModel]
						ON [Product1].[ProductModelID] = [ProductModel].[ProductModelID]
					INNER JOIN [$(EDWStagingSnapshotDb)].[Production].[ProductModelProductDescriptionCulture] [ProductModelCulture]
						ON [ProductModel].[ProductModelID] = [ProductModelCulture].[ProductModelID]
					INNER JOIN [$(EDWStagingSnapshotDb)].[Production].[ProductDescription] [ProductDescriptionChanges]
						ON [ProductModelCulture].[ProductDescriptionID] = [ProductDescriptionChanges].[ProductDescriptionID]
					INNER JOIN [$(EDWStagingSnapshotDb)].[Production].[ProductDescription] [ProductDescription]
						ON [ProductDescriptionChanges].[ProductDescriptionID] = [ProductDescription].[ProductDescriptionID]
					WHERE [Product].[ProductID] = [Product1].[ProductID]
					) Descriptions
		END

	-- save the version number for the next transform
	UPDATE [Controller].[ExecutionState]
	SET [PropertyValue] = CAST(@NextTransfomVersion AS varchar(256))
	WHERE ([PropertyID] = 'DimProductVersion');

	RETURN(0);
END



