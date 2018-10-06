CREATE VIEW [Transform].[DimPromotionChangesView]
AS
SELECT [SpecialOfferID] AS 'PromotionID'
      ,[Description]    AS 'PromotionName'
      ,[DiscountPct]	AS 'PromotionDiscountPercentage'
      ,[Type]			AS 'PromotionType'
      ,[Category]		AS 'PromotionCategory'
      ,[StartDate]		AS 'PromotionStartDate'
      ,[EndDate]        AS 'PromotionEndDate'
      ,[MinQty]			AS 'PromotionMinimumQuantity'
      ,[MaxQty]			AS 'PromotionMaximumQuantity'
  FROM [$(EDWStagingSnapshotDb)].[Sales].[SpecialOffer];
