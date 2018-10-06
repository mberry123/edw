CREATE TABLE [Person].[ContactType] (
    [ContactTypeID] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]          [dbo].[Name] NOT NULL,
    [ModifiedDate]  DATETIME     NOT NULL,
    CONSTRAINT [PK_ContactType_ContactTypeID] PRIMARY KEY CLUSTERED ([ContactTypeID] ASC)
);


GO
ALTER TABLE [Person].[ContactType] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

