CREATE TABLE [Production].[ProductSubcategory] (
    [ProductSubcategoryID] INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ProductCategoryID]    INT              NOT NULL,
    [Name]                 [dbo].[Name]     NOT NULL,
    [rowguid]              UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [ModifiedDate]         DATETIME         NOT NULL,
    CONSTRAINT [PK_ProductSubcategory_ProductSubcategoryID] PRIMARY KEY CLUSTERED ([ProductSubcategoryID] ASC)
);


GO
ALTER TABLE [Production].[ProductSubcategory] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

