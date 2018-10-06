CREATE TABLE [Person].[EmailAddress] (
    [BusinessEntityID] INT              NOT NULL,
    [EmailAddressID]   INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [EmailAddress]     NVARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [rowguid]          UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [ModifiedDate]     DATETIME         NOT NULL,
    CONSTRAINT [PK_EmailAddress_BusinessEntityID_EmailAddressID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC, [EmailAddressID] ASC)
);


GO
ALTER TABLE [Person].[EmailAddress] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

