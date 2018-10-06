CREATE TABLE [Production].[Product] (
    [ProductID]             INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]                  [dbo].[Name]     NOT NULL,
    [ProductNumber]         NVARCHAR (25)    COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [MakeFlag]              [dbo].[Flag]     NOT NULL,
    [FinishedGoodsFlag]     [dbo].[Flag]     NOT NULL,
    [Color]                 NVARCHAR (15)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [SafetyStockLevel]      SMALLINT         NOT NULL,
    [ReorderPoint]          SMALLINT         NOT NULL,
    [StandardCost]          MONEY            NOT NULL,
    [ListPrice]             MONEY            NOT NULL,
    [Size]                  NVARCHAR (5)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [SizeUnitMeasureCode]   NCHAR (3)        COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [WeightUnitMeasureCode] NCHAR (3)        COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Weight]                DECIMAL (8, 2)   NULL,
    [DaysToManufacture]     INT              NOT NULL,
    [ProductLine]           NCHAR (2)        COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Class]                 NCHAR (2)        COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Style]                 NCHAR (2)        COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ProductSubcategoryID]  INT              NULL,
    [ProductModelID]        INT              NULL,
    [SellStartDate]         DATETIME         NOT NULL,
    [SellEndDate]           DATETIME         NULL,
    [DiscontinuedDate]      DATETIME         NULL,
    [rowguid]               UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [ModifiedDate]          DATETIME         NOT NULL,
    CONSTRAINT [PK_Product_ProductID] PRIMARY KEY CLUSTERED ([ProductID] ASC)
);


GO
ALTER TABLE [Production].[Product] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

