CREATE TABLE [Production].[ProductModelProductDescriptionCulture] (
    [ProductModelID]       INT       NOT NULL,
    [ProductDescriptionID] INT       NOT NULL,
    [CultureID]            NCHAR (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [ModifiedDate]         DATETIME  NOT NULL,
    CONSTRAINT [PK_ProductModelProductDescriptionCulture_ProductModelID_ProductDescriptionID_CultureID] PRIMARY KEY CLUSTERED ([ProductModelID] ASC, [ProductDescriptionID] ASC, [CultureID] ASC)
);


GO
ALTER TABLE [Production].[ProductModelProductDescriptionCulture] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

