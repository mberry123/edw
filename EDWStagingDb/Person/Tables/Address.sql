CREATE TABLE [Person].[Address] (
    [AddressID]       INT               IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [AddressLine1]    NVARCHAR (60)     COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [AddressLine2]    NVARCHAR (60)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [City]            NVARCHAR (30)     COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [StateProvinceID] INT               NOT NULL,
    [PostalCode]      NVARCHAR (15)     COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [SpatialLocation] [sys].[geography] NULL,
    [rowguid]         UNIQUEIDENTIFIER  ROWGUIDCOL NOT NULL,
    [ModifiedDate]    DATETIME          NOT NULL,
    CONSTRAINT [PK_Address_AddressID] PRIMARY KEY CLUSTERED ([AddressID] ASC)
);


GO
ALTER TABLE [Person].[Address] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

