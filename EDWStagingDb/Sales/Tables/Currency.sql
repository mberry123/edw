CREATE TABLE [Sales].[Currency] (
    [CurrencyCode] NCHAR (3)    COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Name]         [dbo].[Name] NOT NULL,
    [ModifiedDate] DATETIME     NOT NULL,
    CONSTRAINT [PK_Currency_CurrencyCode] PRIMARY KEY CLUSTERED ([CurrencyCode] ASC)
);


GO
ALTER TABLE [Sales].[Currency] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

