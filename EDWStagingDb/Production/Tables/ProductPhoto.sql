CREATE TABLE [Production].[ProductPhoto] (
    [ProductPhotoID]         INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ThumbNailPhoto]         VARBINARY (MAX) NULL,
    [ThumbnailPhotoFileName] NVARCHAR (50)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [LargePhoto]             VARBINARY (MAX) NULL,
    [LargePhotoFileName]     NVARCHAR (50)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [ModifiedDate]           DATETIME        NOT NULL,
    CONSTRAINT [PK_ProductPhoto_ProductPhotoID] PRIMARY KEY CLUSTERED ([ProductPhotoID] ASC)
);


GO
ALTER TABLE [Production].[ProductPhoto] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

