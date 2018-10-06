CREATE TABLE [Transform].[DimPromotionChangesViewPersisted] (
    [PromotionID]                 INT            NULL,
    [PromotionName]               NVARCHAR (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PromotionDiscountPercentage] SMALLMONEY     NULL,
    [PromotionType]               NVARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PromotionCategory]           NVARCHAR (50)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [PromotionStartDate]          DATETIME       NULL,
    [PromotionEndDate]            DATETIME       NULL,
    [PromotionMinimumQuantity]    INT            NULL,
    [PromotionMaximumQuantity]    INT            NULL
);

