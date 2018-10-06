CREATE TABLE [Transform].[DimSalesTerritoryChangesPersisted] (
    [SalesTerritoryID]      INT             NOT NULL,
    [SalesTerritoryRegion]  NVARCHAR (50)   NOT NULL,
    [SalesTerritoryCountry] NVARCHAR (50)   NOT NULL,
    [SalesTerritoryGroup]   NVARCHAR (50)   NOT NULL,
    [SalesTerritoryImage]   VARBINARY (MAX) NULL
);

