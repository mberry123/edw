CREATE TABLE [Model].[DimPromotion] (
    [PromotionKey]                INT             CONSTRAINT [DF_DimPromotion_PromotionKey] DEFAULT (NEXT VALUE FOR [Controller].[DimPromotionKey]) NOT NULL,
    [ExecutionID]                 BIGINT          NOT NULL,
    [SCDBitmap]                   INT             NOT NULL,
    [StartDate]                   DATETIME        NOT NULL,
    [EndDate]                     DATETIME        NULL,
    [IsLateArrivingMember]        BIT             NOT NULL,
    [PromotionID]                 INT             DEFAULT ((-1)) NOT NULL,
    [PromotionName]               NVARCHAR (255)  DEFAULT ('') NOT NULL,
    [PromotionDiscountPercentage] DECIMAL (38, 2) DEFAULT ((0.00)) NOT NULL,
    [PromotionType]               NVARCHAR (50)   DEFAULT ('') NOT NULL,
    [PromotionCategory]           NVARCHAR (50)   DEFAULT ('') NOT NULL,
    [PromotionStartDate]          DATETIME        DEFAULT ('01 JAN 1900') NOT NULL,
    [PromotionEndDate]            DATETIME        DEFAULT ('01 JAN 1900') NOT NULL,
    [PromotionMinimumQuantity]    INT             DEFAULT ((0)) NOT NULL,
    [PromotionMaximumQuantity]    INT             NULL,
    CONSTRAINT [PK_DimPromotion] PRIMARY KEY CLUSTERED ([PromotionKey] ASC),
    CONSTRAINT [AK_DimPromotion] UNIQUE NONCLUSTERED ([PromotionID] ASC, [EndDate] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimPromotion', @level2type = N'COLUMN', @level2name = N'PromotionKey';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimPromotion', @level2type = N'COLUMN', @level2name = N'ExecutionID';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimPromotion', @level2type = N'COLUMN', @level2name = N'SCDBitmap';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimPromotion', @level2type = N'COLUMN', @level2name = N'StartDate';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimPromotion', @level2type = N'COLUMN', @level2name = N'EndDate';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimPromotion', @level2type = N'COLUMN', @level2name = N'IsLateArrivingMember';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'BK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimPromotion', @level2type = N'COLUMN', @level2name = N'PromotionID';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimPromotion', @level2type = N'COLUMN', @level2name = N'PromotionName';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimPromotion', @level2type = N'COLUMN', @level2name = N'PromotionDiscountPercentage';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimPromotion', @level2type = N'COLUMN', @level2name = N'PromotionType';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimPromotion', @level2type = N'COLUMN', @level2name = N'PromotionCategory';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimPromotion', @level2type = N'COLUMN', @level2name = N'PromotionStartDate';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimPromotion', @level2type = N'COLUMN', @level2name = N'PromotionEndDate';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimPromotion', @level2type = N'COLUMN', @level2name = N'PromotionMinimumQuantity';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimPromotion', @level2type = N'COLUMN', @level2name = N'PromotionMaximumQuantity';

