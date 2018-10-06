CREATE TABLE [Sales].[SalesTerritoryImage] (
    [TerritoryID]         INT             NOT NULL,
    [SalesTerritoryImage] VARBINARY (MAX) NULL,
    CONSTRAINT [PK_SalesTerritory_TerritoryIDImage] PRIMARY KEY CLUSTERED ([TerritoryID] ASC)
);


GO
ALTER TABLE [Sales].[SalesTerritoryImage] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

