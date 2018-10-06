CREATE TABLE [Production].[ProductModel] (
    [ProductModelID]     INT                                                            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]               [dbo].[Name]                                                   NOT NULL,
    [CatalogDescription] XML(CONTENT [Production].[ProductDescriptionSchemaCollection]) NULL,
    [Instructions]       XML(CONTENT [Production].[ManuInstructionsSchemaCollection])   NULL,
    [rowguid]            UNIQUEIDENTIFIER                                               ROWGUIDCOL NOT NULL,
    [ModifiedDate]       DATETIME                                                       NOT NULL,
    CONSTRAINT [PK_ProductModel_ProductModelID] PRIMARY KEY CLUSTERED ([ProductModelID] ASC)
);


GO
ALTER TABLE [Production].[ProductModel] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

