CREATE TABLE [Transform].[DimSalesTerritoryChanges] (
    [SalesTerritoryKey]     INT             NOT NULL,
    [ExecutionID]           BIGINT          NOT NULL,
    [SCDBitmap]             INT             NOT NULL,
    [StartDate]             DATETIME        NOT NULL,
    [EndDate]               DATETIME        NULL,
    [IsLateArrivingMember]  BIT             NOT NULL,
    [SalesTerritoryId]      INT             NULL,
    [SalesTerritoryRegion]  NVARCHAR (50)   DEFAULT ('') NOT NULL,
    [SalesTerritoryCountry] NVARCHAR (50)   DEFAULT ('') NOT NULL,
    [SalesTerritoryGroup]   NVARCHAR (50)   NULL,
    [SalesTerritoryImage]   VARBINARY (MAX) DEFAULT (CONVERT([varbinary](max),'0x')) NOT NULL
);

