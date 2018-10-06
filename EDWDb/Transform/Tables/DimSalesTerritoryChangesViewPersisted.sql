CREATE TABLE [Transform].[DimSalesTerritoryChangesViewPersisted] (
    [SalesTerritoryID]      INT             NULL,
    [SalesTerritoryRegion]  NVARCHAR (50)   NULL,
    [SalesTerritoryCountry] NVARCHAR (50)   NULL,
    [SalesTerritoryGroup]   NVARCHAR (50)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [SalesTerritoryImage]   VARBINARY (MAX) NULL
);

