CREATE TABLE [Sales].[SalesTerritory] (
    [TerritoryID]       INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]              [dbo].[Name]     NOT NULL,
    [CountryRegionCode] NVARCHAR (3)     COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Group]             NVARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [SalesYTD]          MONEY            NOT NULL,
    [SalesLastYear]     MONEY            NOT NULL,
    [CostYTD]           MONEY            NOT NULL,
    [CostLastYear]      MONEY            NOT NULL,
    [rowguid]           UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [ModifiedDate]      DATETIME         NOT NULL,
    CONSTRAINT [PK_SalesTerritory_TerritoryID] PRIMARY KEY CLUSTERED ([TerritoryID] ASC)
);


GO
ALTER TABLE [Sales].[SalesTerritory] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

