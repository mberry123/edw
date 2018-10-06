CREATE TABLE [Model].[FactResellerSales] (
    [ExecutionID]                              BIGINT          NOT NULL,
    [PartitionKey]                             DATE            NOT NULL,
    [ProductKey]                               INT             DEFAULT ((-1)) NOT NULL,
    [OrderDateKey]                             INT             DEFAULT ((-1)) NOT NULL,
    [DueDateKey]                               INT             DEFAULT ((-1)) NOT NULL,
    [ShipDateKey]                              INT             DEFAULT ((-1)) NOT NULL,
    [ResellerKey]                              INT             DEFAULT ((-1)) NOT NULL,
    [EmployeeKey]                              INT             DEFAULT ((-1)) NOT NULL,
    [PromotionKey]                             INT             DEFAULT ((-1)) NOT NULL,
    [CurrencyKey]                              INT             DEFAULT ((-1)) NOT NULL,
    [SalesTerritoryKey]                        INT             DEFAULT ((-1)) NOT NULL,
    [ResellerSalesOrderNumber]                 INT             NOT NULL,
    [ResellerSalesOrderLineNumber]             INT             NOT NULL,
    [ResellerSalesRevisionNumber]              INT             NOT NULL,
    [ResellerSalesOrderQuantity]               INT             NOT NULL,
    [ResellerSalesUnitPrice]                   DECIMAL (18, 4) NOT NULL,
    [ResellerSalesExtendedAmount]              DECIMAL (18, 4) NULL,
    [ResellerSalesUnitPriceDiscountPercentage] DECIMAL (18, 4) NOT NULL,
    [ResellerSalesDiscountAmount]              DECIMAL (18, 4) NULL,
    [ResellerSalesUnitProductStandardCost]     DECIMAL (18, 4) NOT NULL,
    [ResellerSalesTotalProductCost]            DECIMAL (18, 4) NULL,
    [ResellerSalesAmount]                      DECIMAL (18, 4) NULL,
    [ResellerSalesTaxAmount]                   DECIMAL (18, 4) NULL,
    [ResellerSalesFreightAmount]               DECIMAL (18, 4) NULL,
    [CarrierTrackingNumber]                    NVARCHAR (25)   NULL,
    [PurchaseOrderNumber]                      NVARCHAR (25)   NULL,
    [OrderDate]                                DATETIME        NOT NULL,
    [DueDate]                                  DATETIME        NOT NULL,
    [ShipDate]                                 DATETIME        NULL,
    CONSTRAINT [PK_FactResellerSales] PRIMARY KEY CLUSTERED ([PartitionKey] ASC, [ResellerSalesOrderNumber] ASC, [ResellerSalesOrderLineNumber] ASC) ON [FactHistoryPSC] ([PartitionKey]),
    CONSTRAINT [FK_ResellerSales_DimCurrency] FOREIGN KEY ([CurrencyKey]) REFERENCES [Model].[DimDescription] ([DescriptionKey]),
    CONSTRAINT [FK_ResellerSales_DimDueDate] FOREIGN KEY ([DueDateKey]) REFERENCES [Model].[DimDate] ([DateKey]),
    CONSTRAINT [FK_ResellerSales_DimEmployee] FOREIGN KEY ([EmployeeKey]) REFERENCES [Model].[DimEmployee] ([EmployeeKey]),
    CONSTRAINT [FK_ResellerSales_DimOrderDate] FOREIGN KEY ([OrderDateKey]) REFERENCES [Model].[DimDate] ([DateKey]),
    CONSTRAINT [FK_ResellerSales_DimProduct] FOREIGN KEY ([ProductKey]) REFERENCES [Model].[DimProduct] ([ProductKey]),
    CONSTRAINT [FK_ResellerSales_DimPromotion] FOREIGN KEY ([PromotionKey]) REFERENCES [Model].[DimPromotion] ([PromotionKey]),
    CONSTRAINT [FK_ResellerSales_DimReseller] FOREIGN KEY ([ResellerKey]) REFERENCES [Model].[DimReseller] ([ResellerKey]),
    CONSTRAINT [FK_ResellerSales_DimSalesTerritory] FOREIGN KEY ([SalesTerritoryKey]) REFERENCES [Model].[DimSalesTerritory] ([SalesTerritoryKey]),
    CONSTRAINT [FK_ResellerSales_DimShipDate] FOREIGN KEY ([ShipDateKey]) REFERENCES [Model].[DimDate] ([DateKey])
);


GO
CREATE COLUMNSTORE INDEX [CSI_FactResellerSales]
    ON [Model].[FactResellerSales]([OrderDate], [DueDate], [ShipDate], [ProductKey], [ResellerKey], [EmployeeKey], [PromotionKey], [CurrencyKey], [SalesTerritoryKey])
    ON [FactHistoryPSC] ([PartitionKey]);


GO
EXECUTE sp_addextendedproperty @name = N'TableType', @value = N'AS', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'ExecutionID';


GO
EXECUTE sp_addextendedproperty @name = N'FactType', @value = N'DC', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'PartitionKey';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'SK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'PartitionKey';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'FK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'ProductKey';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'FK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'OrderDateKey';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'FK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'DueDateKey';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'FK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'ShipDateKey';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'FK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'ResellerKey';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'FK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'EmployeeKey';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'FK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'PromotionKey';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'FK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'CurrencyKey';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'FK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'SalesTerritoryKey';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'BK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'ResellerSalesOrderNumber';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'BK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'ResellerSalesOrderLineNumber';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnType', @value = N'DD', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'ResellerSalesRevisionNumber';


GO
EXECUTE sp_addextendedproperty @name = N'FactType', @value = N'SA', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'ResellerSalesOrderQuantity';


GO
EXECUTE sp_addextendedproperty @name = N'FactType', @value = N'NA', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'ResellerSalesUnitPrice';


GO
EXECUTE sp_addextendedproperty @name = N'FactType', @value = N'FA', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'ResellerSalesExtendedAmount';


GO
EXECUTE sp_addextendedproperty @name = N'FactType', @value = N'NA', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'ResellerSalesUnitPriceDiscountPercentage';


GO
EXECUTE sp_addextendedproperty @name = N'FactType', @value = N'FA', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'ResellerSalesDiscountAmount';


GO
EXECUTE sp_addextendedproperty @name = N'FactType', @value = N'FA', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'ResellerSalesUnitProductStandardCost';


GO
EXECUTE sp_addextendedproperty @name = N'FactType', @value = N'FA', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'ResellerSalesTotalProductCost';


GO
EXECUTE sp_addextendedproperty @name = N'FactType', @value = N'FA', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'ResellerSalesAmount';


GO
EXECUTE sp_addextendedproperty @name = N'FactType', @value = N'FA', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'ResellerSalesTaxAmount';


GO
EXECUTE sp_addextendedproperty @name = N'FactType', @value = N'FA', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'ResellerSalesFreightAmount';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnType', @value = N'DD', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'CarrierTrackingNumber';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnType', @value = N'DD', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'PurchaseOrderNumber';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'BK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'OrderDate';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnType', @value = N'DD', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'DueDate';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnType', @value = N'DD', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'FactResellerSales', @level2type = N'COLUMN', @level2name = N'ShipDate';

