CREATE TABLE [Person].[CountryRegion] (
    [CountryRegionCode] NVARCHAR (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Name]              [dbo].[Name] NOT NULL,
    [ModifiedDate]      DATETIME     NOT NULL,
    CONSTRAINT [PK_CountryRegion_CountryRegionCode] PRIMARY KEY CLUSTERED ([CountryRegionCode] ASC)
);


GO
ALTER TABLE [Person].[CountryRegion] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

