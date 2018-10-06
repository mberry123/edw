CREATE VIEW [Transform].[DimProductChangesView]
AS
SELECT
	 [Product].[ProductNumber] COLLATE Latin1_General_CI_AS  AS 'ProductCode'
	,[ProductCategory].[Name] AS 'ProductCategoryName'
	,[ProductSubCategory].[Name] AS 'ProductSubcategoryName'
	,[Product].[WeightUnitMeasureCode] COLLATE Latin1_General_CI_AS  AS 'ProductWeightUnitMeasureCode'
	,[Product].[SizeUnitMeasureCode] COLLATE Latin1_General_CI_AS  AS 'ProductSizeUnitMeasureCode'
	,[Product].[Name] AS 'ProductName'
	,[Product].[StandardCost] AS 'ProductStandardCost'
	,[Product].[FinishedGoodsFlag] AS 'ProductFinishedGoodsFlag'
	,ISNULL([Product].[Color], 'N/A')  COLLATE Latin1_General_CI_AS  AS 'ProductColour'
	,[Product].[SafetyStockLevel] AS 'ProductSafetyStockLevel'
	,[Product].[ReorderPoint] AS 'ProductReorderPoint'
	,[Product].[ListPrice] AS 'ProductListPrice'
	,[Product].[Size] COLLATE Latin1_General_CI_AS  AS 'ProductSize'
	,ISNULL(CASE 
			WHEN [Product].[Size] >= '38'
				AND [Product].[Size] <= '40'
				AND [Product].[SizeUnitMeasureCode] = 'CM'
				THEN '38-40 CM'
			ELSE CASE 
					WHEN [Product].[Size] >= '42'
						AND [Product].[Size] <= '46'
						AND [Product].[SizeUnitMeasureCode] = 'CM'
						THEN '42-46 CM'
					ELSE CASE 
							WHEN [Product].[Size] >= '48'
								AND [Product].[Size] <= '52'
								AND [Product].[SizeUnitMeasureCode] = 'CM'
								THEN '48-52 CM'
							ELSE CASE 
									WHEN [Product].[Size] >= '54'
										AND [Product].[Size] <= '58'
										AND [Product].[SizeUnitMeasureCode] = 'CM'
										THEN '54-58 CM'
									ELSE CASE 
											WHEN [Product].[Size] >= '60'
												AND [Product].[Size] <= '62'
												AND [Product].[SizeUnitMeasureCode] = 'CM'
												THEN '60-62 CM'
											ELSE [Product].[Size]
											END
									END
							END
					END
			END, 'N/A')  COLLATE Latin1_General_CI_AS  AS 'ProductSizeRange'
	,[Product].[Weight] AS 'ProductWeight'
	,[Product].[DaysToManufacture] AS 'ProductDaysToManufacture'
	,[Product].[ProductLine]  COLLATE Latin1_General_CI_AS AS 'ProductLine'
	,[$(EDWStagingSnapshotDb)].[dbo].[ufnGetProductDealerPrice]([Product].[ProductID], GETDATE()) AS 'DealerPrice'
	,[Product].[Class] COLLATE Latin1_General_CI_AS  AS 'ProductClass'
	,[Product].[Style]  COLLATE Latin1_General_CI_AS  AS 'ProductStyle'
	,[Model].[Name] AS 'ProductModelName'
	,[Photos].[LargePhoto] AS 'ProductLargePhoto'
	,[Descriptions].[Description] COLLATE Latin1_General_CI_AS AS 'ProductDescription'
	,[Product].[ProductID]
FROM [$(EDWStagingSnapshotDb)].[Production].[Product] Product
INNER JOIN [Transform].[DimProductChangedKeys] Changes
	ON ([Product].[ProductNumber] = [Changes].[ProductCode])
LEFT JOIN [$(EDWStagingSnapshotDb)].[Production].[ProductSubcategory] ProductSubCategory
	ON ([Product].[ProductSubCategoryID] = [ProductSubCategory].[ProductSubCategoryID])
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
	INNER JOIN [$(EDWStagingSnapshotDb)].[Production].[ProductDescription] [ProductDescription]
		ON [ProductModelCulture].[ProductDescriptionID] = [ProductDescription].[ProductDescriptionID]
	WHERE [Product].[ProductID] = [Product1].[ProductID]
	) Descriptions;



