CREATE TABLE [Person].[PersonPhone] (
    [BusinessEntityID]  INT           NOT NULL,
    [PhoneNumber]       [dbo].[Phone] NOT NULL,
    [PhoneNumberTypeID] INT           NOT NULL,
    [ModifiedDate]      DATETIME      NOT NULL,
    CONSTRAINT [PK_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC, [PhoneNumber] ASC, [PhoneNumberTypeID] ASC)
);


GO
ALTER TABLE [Person].[PersonPhone] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

