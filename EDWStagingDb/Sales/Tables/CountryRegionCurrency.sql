CREATE TABLE [Sales].[CountryRegionCurrency] (
    [CountryRegionCode] NVARCHAR (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [CurrencyCode]      NCHAR (3)    COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [ModifiedDate]      DATETIME     NOT NULL,
    CONSTRAINT [PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode] PRIMARY KEY CLUSTERED ([CountryRegionCode] ASC, [CurrencyCode] ASC)
);


GO
ALTER TABLE [Sales].[CountryRegionCurrency] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

