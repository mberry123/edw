CREATE TABLE [Production].[ProductProductPhoto] (
    [ProductID]      INT          NOT NULL,
    [ProductPhotoID] INT          NOT NULL,
    [Primary]        [dbo].[Flag] NOT NULL,
    [ModifiedDate]   DATETIME     NOT NULL,
    CONSTRAINT [PK_ProductProductPhoto_ProductID_ProductPhotoID] PRIMARY KEY NONCLUSTERED ([ProductID] ASC, [ProductPhotoID] ASC)
);


GO
ALTER TABLE [Production].[ProductProductPhoto] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

