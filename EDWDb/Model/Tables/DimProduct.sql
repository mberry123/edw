CREATE TABLE [Model].[DimProduct] (
    [ProductKey]                   INT             CONSTRAINT [DF_DimProduct_ProductKey] DEFAULT (NEXT VALUE FOR [Controller].[DimProductKey]) NOT NULL,
    [ExecutionID]                  BIGINT          NOT NULL,
    [SCDBitmap]                    INT             NOT NULL,
    [StartDate]                    DATETIME        NOT NULL,
    [EndDate]                      DATETIME        NULL,
    [IsLateArrivingMember]         BIT             NOT NULL,
    [ProductCode]                  NVARCHAR (25)   DEFAULT ('') NOT NULL,
    [ProductCategoryName]          NVARCHAR (50)   NULL,
    [ProductSubcategoryName]       NVARCHAR (50)   NULL,
    [ProductWeightUnitMeasureCode] NCHAR (3)       NULL,
    [ProductSizeUnitMeasureCode]   NCHAR (3)       NULL,
    [ProductName]                  NVARCHAR (50)   DEFAULT ('') NOT NULL,
    [ProductStandardCost]          MONEY           DEFAULT ((0.00)) NOT NULL,
    [ProductFinishedGoodsFlag]     BIT             DEFAULT ((0)) NOT NULL,
    [ProductColour]                NVARCHAR (15)   DEFAULT ('') NOT NULL,
    [ProductSafetyStockLevel]      SMALLINT        DEFAULT ((0)) NOT NULL,
    [ProductReorderPoint]          SMALLINT        DEFAULT ((0)) NOT NULL,
    [ProductListPrice]             MONEY           DEFAULT ((0.00)) NOT NULL,
    [ProductSize]                  NVARCHAR (5)    NULL,
    [ProductSizeRange]             NVARCHAR (8)    DEFAULT ('') NOT NULL,
    [ProductWeight]                DECIMAL (8, 2)  NULL,
    [ProductDaysToManufacture]     INT             DEFAULT ((0)) NOT NULL,
    [ProductLine]                  NCHAR (2)       NULL,
    [DealerPrice]                  MONEY           NULL,
    [ProductClass]                 NCHAR (2)       NULL,
    [ProductStyle]                 NCHAR (2)       NULL,
    [ProductModelName]             NVARCHAR (50)   NULL,
    [ProductLargePhoto]            VARBINARY (MAX) NULL,
    [ProductDescription]           NVARCHAR (400)  NULL,
    [ProductID]                    INT             NULL,
    CONSTRAINT [PK_DimProduct] PRIMARY KEY CLUSTERED ([ProductKey] ASC),
    CONSTRAINT [AK_DimProduct] UNIQUE NONCLUSTERED ([ProductCode] ASC, [EndDate] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'TableLoadOrder', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct';


GO
EXECUTE sp_addextendedproperty @name = N'TableType', @value = N'HD', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductKey';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ExecutionID';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'SCDBitmap';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'StartDate';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'EndDate';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'IsLateArrivingMember';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'BK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductCode';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductCategoryName';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductSubcategoryName';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductWeightUnitMeasureCode';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductSizeUnitMeasureCode';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductName';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductStandardCost';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductFinishedGoodsFlag';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductColour';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductSafetyStockLevel';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductReorderPoint';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductListPrice';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductSize';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductSizeRange';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductWeight';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductDaysToManufacture';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductLine';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'DealerPrice';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductClass';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductStyle';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductModelName';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductLargePhoto';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductDescription';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimProduct', @level2type = N'COLUMN', @level2name = N'ProductID';

