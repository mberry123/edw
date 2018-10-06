CREATE TABLE [Sales].[SpecialOffer] (
    [SpecialOfferID] INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Description]    NVARCHAR (255)   COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [DiscountPct]    SMALLMONEY       NOT NULL,
    [Type]           NVARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Category]       NVARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [StartDate]      DATETIME         NOT NULL,
    [EndDate]        DATETIME         NOT NULL,
    [MinQty]         INT              NOT NULL,
    [MaxQty]         INT              NULL,
    [rowguid]        UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [ModifiedDate]   DATETIME         NOT NULL,
    CONSTRAINT [PK_SpecialOffer_SpecialOfferID] PRIMARY KEY CLUSTERED ([SpecialOfferID] ASC)
);


GO
ALTER TABLE [Sales].[SpecialOffer] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

