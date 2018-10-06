CREATE TABLE [Transform].[DimPromotionChanges] (
    [PromotionKey]                INT             NOT NULL,
    [ExecutionID]                 BIGINT          NOT NULL,
    [SCDBitmap]                   INT             NOT NULL,
    [StartDate]                   DATETIME        NOT NULL,
    [EndDate]                     DATETIME        NULL,
    [IsLateArrivingMember]        BIT             NOT NULL,
    [PromotionID]                 INT             NOT NULL,
    [PromotionName]               NVARCHAR (255)  DEFAULT ('') NOT NULL,
    [PromotionDiscountPercentage] DECIMAL (38, 2) DEFAULT ((0.00)) NOT NULL,
    [PromotionType]               NVARCHAR (50)   DEFAULT ('') NOT NULL,
    [PromotionCategory]           NVARCHAR (50)   DEFAULT ('') NOT NULL,
    [PromotionStartDate]          DATETIME        DEFAULT ('01 JAN 1900') NOT NULL,
    [PromotionEndDate]            DATETIME        DEFAULT ('01 JAN 1900') NOT NULL,
    [PromotionMinimumQuantity]    INT             DEFAULT ((0)) NOT NULL,
    [PromotionMaximumQuantity]    INT             NULL
);

