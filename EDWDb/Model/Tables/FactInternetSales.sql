CREATE TABLE [Model].[FactInternetSales] (
    [ExecutionID]                              BIGINT          NOT NULL,
    [PartitionKey]                             DATE            NOT NULL,
    [ProductKey]                               INT             DEFAULT ((-1)) NOT NULL,
    [OrderDateKey]                             INT             DEFAULT ((-1)) NOT NULL,
    [DueDateKey]                               INT             DEFAULT ((-1)) NOT NULL,
    [ShipDateKey]                              INT             DEFAULT ((-1)) NOT NULL,
    [CustomerKey]                              INT             DEFAULT ((-1)) NOT NULL,
    [PromotionKey]                             INT             DEFAULT ((-1)) NOT NULL,
    [CurrencyKey]                              INT             DEFAULT ((-1)) NOT NULL,
    [SalesTerritoryKey]                        INT             DEFAULT ((-1)) NOT NULL,
    [InternetSalesOrderNumber]                 INT             NOT NULL,
    [InternetSalesOrderLineNumber]             INT             NOT NULL,
    [InternetSalesRevisionNumber]              INT             NOT NULL,
    [InternetSalesOrderQuantity]               INT             NOT NULL,
    [InternetSalesUnitPrice]                   DECIMAL (18, 4) NOT NULL,
    [InternetSalesExtendedAmount]              DECIMAL (18, 4) NULL,
    [InternetSalesUnitPriceDiscountPercentage] DECIMAL (18, 4) NOT NULL,
    [InternetSalesDiscountAmount]              DECIMAL (18, 4) NULL,
    [InternetSalesUnitProductStandardCost]     DECIMAL (18, 4) NOT NULL,
    [InternetSalesTotalProductCost]            DECIMAL (18, 4) NULL,
    [InternetSalesAmount]                      DECIMAL (18, 4) NULL,
    [InternetSalesTaxAmount]                   DECIMAL (18, 4) NULL,
    [InternetSalesFreightAmount]               DECIMAL (18, 4) NULL,
    [CarrierTrackingNumber]                    NVARCHAR (25)   NULL,
    [PurchaseOrderNumber]                      NVARCHAR (25)   NULL,
    [OrderDate]                                DATETIME        NOT NULL,
    [DueDate]                                  DATETIME        NOT NULL,
    [ShipDate]                                 DATETIME        NULL,
    CONSTRAINT [PK_FactInternetSales] PRIMARY KEY CLUSTERED ([PartitionKey] ASC, [InternetSalesOrderNumber] ASC, [InternetSalesOrderLineNumber] ASC) ON [FactHistoryPSC] ([PartitionKey]),
    CONSTRAINT [FK_InternetSales_DimCurrency] FOREIGN KEY ([CurrencyKey]) REFERENCES [Model].[DimDescription] ([DescriptionKey]),
    CONSTRAINT [FK_InternetSales_DimCustomer] FOREIGN KEY ([CustomerKey]) REFERENCES [Model].[DimCustomer] ([CustomerKey]),
    CONSTRAINT [FK_InternetSales_DimDueDate] FOREIGN KEY ([DueDateKey]) REFERENCES [Model].[DimDate] ([DateKey]),
    CONSTRAINT [FK_InternetSales_DimOrderDate] FOREIGN KEY ([OrderDateKey]) REFERENCES [Model].[DimDate] ([DateKey]),
    CONSTRAINT [FK_InternetSales_DimProduct] FOREIGN KEY ([ProductKey]) REFERENCES [Model].[DimProduct] ([ProductKey]),
    CONSTRAINT [FK_InternetSales_DimPromotion] FOREIGN KEY ([PromotionKey]) REFERENCES [Model].[DimPromotion] ([PromotionKey]),
    CONSTRAINT [FK_InternetSales_DimSalesTerritory] FOREIGN KEY ([SalesTerritoryKey]) REFERENCES [Model].[DimSalesTerritory] ([SalesTerritoryKey]),
    CONSTRAINT [FK_InternetSales_DimShipDate] FOREIGN KEY ([ShipDateKey]) REFERENCES [Model].[DimDate] ([DateKey])
);


GO
CREATE COLUMNSTORE INDEX [CSI_FactInternetSales]
    ON [Model].[FactInternetSales]([OrderDate], [DueDate], [ShipDate], [ProductKey], [CustomerKey], [PromotionKey], [CurrencyKey], [SalesTerritoryKey])
    ON [FactHistoryPSC] ([PartitionKey]);


GO
EXECUTE sp_addextendedproperty @name = N'TableType', @value = N'AS', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'ExecutionID';


GO
EXECUTE sp_addextendedproperty @name = N'FactType', @value = N'DC', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'PartitionKey';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'SK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'PartitionKey';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'FK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'ProductKey';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'FK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'OrderDateKey';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'FK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'DueDateKey';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'FK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'ShipDateKey';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'FK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'CustomerKey';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'FK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'PromotionKey';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'FK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'CurrencyKey';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'FK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'SalesTerritoryKey';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'BK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'InternetSalesOrderNumber';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'BK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'InternetSalesOrderLineNumber';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnType', @value = N'DD', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'InternetSalesRevisionNumber';


GO
EXECUTE sp_addextendedproperty @name = N'FactType', @value = N'SA', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'InternetSalesOrderQuantity';


GO
EXECUTE sp_addextendedproperty @name = N'FactType', @value = N'NA', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'InternetSalesUnitPrice';


GO
EXECUTE sp_addextendedproperty @name = N'FactType', @value = N'FA', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'InternetSalesExtendedAmount';


GO
EXECUTE sp_addextendedproperty @name = N'FactType', @value = N'NA', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'InternetSalesUnitPriceDiscountPercentage';


GO
EXECUTE sp_addextendedproperty @name = N'FactType', @value = N'FA', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'InternetSalesDiscountAmount';


GO
EXECUTE sp_addextendedproperty @name = N'FactType', @value = N'FA', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'InternetSalesUnitProductStandardCost';


GO
EXECUTE sp_addextendedproperty @name = N'FactType', @value = N'FA', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'InternetSalesTotalProductCost';


GO
EXECUTE sp_addextendedproperty @name = N'FactType', @value = N'FA', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'InternetSalesAmount';


GO
EXECUTE sp_addextendedproperty @name = N'FactType', @value = N'FA', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'InternetSalesTaxAmount';


GO
EXECUTE sp_addextendedproperty @name = N'FactType', @value = N'FA', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'InternetSalesFreightAmount';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnType', @value = N'DD', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'CarrierTrackingNumber';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnType', @value = N'DD', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'PurchaseOrderNumber';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'BK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'OrderDate';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnType', @value = N'DD', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'DueDate';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnType', @value = N'DD', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactInternetSales', @level2type = N'COLUMN', @level2name = N'ShipDate';

