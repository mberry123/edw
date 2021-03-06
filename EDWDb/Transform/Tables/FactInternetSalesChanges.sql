﻿CREATE TABLE [Transform].[FactInternetSalesChanges] (
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
    [ShipDate]                                 DATETIME        NULL
);

