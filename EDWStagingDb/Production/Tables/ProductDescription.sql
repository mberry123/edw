CREATE TABLE [Production].[ProductDescription] (
    [ProductDescriptionID] INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Description]          NVARCHAR (400)   COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [rowguid]              UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [ModifiedDate]         DATETIME         NOT NULL,
    CONSTRAINT [PK_ProductDescription_ProductDescriptionID] PRIMARY KEY CLUSTERED ([ProductDescriptionID] ASC)
);


GO
ALTER TABLE [Production].[ProductDescription] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

