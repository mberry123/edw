CREATE VIEW [Model].[DimPromotionView]
AS
SELECT [PromotionKey] AS 'Promotion Key'
      ,[StartDate] AS 'Promotion Row Creation Date'
      ,[EndDate] AS 'Promotion Row Closed Date'
	  ,CASE WHEN [EndDate] IS NULL THEN 1 ELSE 0 END  AS 'Promotion Current Row Flag'
      ,[PromotionID]					  AS 'Promotion ID'
      ,[PromotionName]					  AS 'Promotion Name'
      ,[PromotionDiscountPercentage]	  AS 'Promotion Discount Percentage'
      ,[PromotionType]					  AS 'Promotion Type'
      ,[PromotionCategory]				  AS 'Promotion Category'
      ,[PromotionStartDate]				  AS 'Promotion Start Date'
      ,[PromotionEndDate]				  AS 'Promotion End Date'
      ,[PromotionMinimumQuantity]		  AS 'Promotion Minimum Quantity'
      ,[PromotionMaximumQuantity]		  AS 'Promotion Maximum Quantity'
  FROM [Model].[DimPromotion];

