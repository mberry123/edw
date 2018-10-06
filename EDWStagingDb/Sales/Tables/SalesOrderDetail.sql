CREATE TABLE [Sales].[SalesOrderDetail] (
    [SalesOrderID]          INT              NOT NULL,
    [SalesOrderDetailID]    INT              NOT NULL,
    [CarrierTrackingNumber] NVARCHAR (25)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [OrderQty]              SMALLINT         NOT NULL,
    [ProductID]             INT              NOT NULL,
    [SpecialOfferID]        INT              NOT NULL,
    [UnitPrice]             MONEY            NOT NULL,
    [UnitPriceDiscount]     MONEY            NOT NULL,
    [LineTotal]             AS               (isnull(([UnitPrice]*((1.0)-[UnitPriceDiscount]))*[OrderQty],(0.0))),
    [rowguid]               UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [ModifiedDate]          DATETIME         NOT NULL,
    CONSTRAINT [PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID] PRIMARY KEY CLUSTERED ([SalesOrderID] ASC, [SalesOrderDetailID] ASC)
);


GO
ALTER TABLE [Sales].[SalesOrderDetail] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

