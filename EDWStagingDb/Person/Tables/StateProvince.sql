CREATE TABLE [Person].[StateProvince] (
    [StateProvinceID]         INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [StateProvinceCode]       NCHAR (3)        COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [CountryRegionCode]       NVARCHAR (3)     COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [IsOnlyStateProvinceFlag] [dbo].[Flag]     NOT NULL,
    [Name]                    [dbo].[Name]     NOT NULL,
    [TerritoryID]             INT              NOT NULL,
    [rowguid]                 UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [ModifiedDate]            DATETIME         NOT NULL,
    CONSTRAINT [PK_StateProvince_StateProvinceID] PRIMARY KEY CLUSTERED ([StateProvinceID] ASC)
);


GO
ALTER TABLE [Person].[StateProvince] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

