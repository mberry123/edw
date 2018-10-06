CREATE TABLE [Person].[PhoneNumberType] (
    [PhoneNumberTypeID] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]              [dbo].[Name] NOT NULL,
    [ModifiedDate]      DATETIME     NOT NULL,
    CONSTRAINT [PK_PhoneNumberType_PhoneNumberTypeID] PRIMARY KEY CLUSTERED ([PhoneNumberTypeID] ASC)
);


GO
ALTER TABLE [Person].[PhoneNumberType] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

