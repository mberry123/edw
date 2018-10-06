CREATE TABLE [Model].[DimSalesTerritory] (
    [SalesTerritoryKey]     INT             CONSTRAINT [DF_DimSalesTerritory_SalesTerritoryKey] DEFAULT (NEXT VALUE FOR [Controller].[DimSalesTerritoryKey]) NOT NULL,
    [ExecutionID]           BIGINT          NOT NULL,
    [SCDBitmap]             INT             NOT NULL,
    [StartDate]             DATETIME        NOT NULL,
    [EndDate]               DATETIME        NULL,
    [IsLateArrivingMember]  BIT             NOT NULL,
    [SalesTerritoryId]      INT             DEFAULT ((-1)) NOT NULL,
    [SalesTerritoryRegion]  NVARCHAR (50)   DEFAULT ('') NOT NULL,
    [SalesTerritoryCountry] NVARCHAR (50)   DEFAULT ('') NOT NULL,
    [SalesTerritoryGroup]   NVARCHAR (50)   NULL,
    [SalesTerritoryImage]   VARBINARY (MAX) DEFAULT (CONVERT([varbinary](max),'0x')) NOT NULL,
    CONSTRAINT [PK_DimSalesTerritory] PRIMARY KEY CLUSTERED ([SalesTerritoryKey] ASC),
    CONSTRAINT [AK_DimSalesTerritory] UNIQUE NONCLUSTERED ([SalesTerritoryId] ASC, [EndDate] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'TableLoadOrder', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimSalesTerritory';


GO
EXECUTE sp_addextendedproperty @name = N'TableType', @value = N'HD', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimSalesTerritory';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimSalesTerritory', @level2type = N'COLUMN', @level2name = N'SalesTerritoryKey';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimSalesTerritory', @level2type = N'COLUMN', @level2name = N'ExecutionID';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimSalesTerritory', @level2type = N'COLUMN', @level2name = N'SCDBitmap';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimSalesTerritory', @level2type = N'COLUMN', @level2name = N'StartDate';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimSalesTerritory', @level2type = N'COLUMN', @level2name = N'EndDate';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimSalesTerritory', @level2type = N'COLUMN', @level2name = N'IsLateArrivingMember';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimSalesTerritory', @level2type = N'COLUMN', @level2name = N'SalesTerritoryId';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'BK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimSalesTerritory', @level2type = N'COLUMN', @level2name = N'SalesTerritoryId';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimSalesTerritory', @level2type = N'COLUMN', @level2name = N'SalesTerritoryRegion';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimSalesTerritory', @level2type = N'COLUMN', @level2name = N'SalesTerritoryCountry';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimSalesTerritory', @level2type = N'COLUMN', @level2name = N'SalesTerritoryGroup';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimSalesTerritory', @level2type = N'COLUMN', @level2name = N'SalesTerritoryImage';

