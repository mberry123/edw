CREATE PROCEDURE [Report].[ProductCatalog]
AS
SELECT [ProductSubcategoryName] AS 'ProdSubCat'
      ,[ProductModelName] AS 'ProdModel'
	  ,[ProductCategoryName] AS 'ProdCat'
      ,[ProductDescription] AS 'Description'
	  ,[ProductLargePhoto] AS 'LargePhoto'
	  ,[ProductName] AS 'ProdName'
      ,[ProductCode] AS 'ProductNumber'
      ,NULLIF([ProductColour],'N/A') AS 'Color'
      ,[ProductSize] AS 'Size'
      ,[ProductWeight] AS 'Weight'
      ,[ProductStandardCost] AS 'StandardCost'
      ,[ProductStyle] AS 'Style'
      ,[ProductClass] AS 'Class'
      ,[ProductListPrice] AS 'ListPrice'
  FROM [EDWDb].[Model].[DimProduct]
  WHERE [EndDate] IS NULL
  AND [ProductSubcategoryName] IS NOT NULL
  AND [ProductKey] > -1
  AND [IsLateArrivingMember] = 0;
