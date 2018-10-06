CREATE TABLE [Sales].[StoreOrderStats] (
    [BusinessEntityID] INT      NOT NULL,
    [OrderFrequency]   CHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [OrderMonth]       TINYINT  NULL,
    [FirstOrderYear]   INT      NULL,
    [LastOrderYear]    INT      NULL,
    [MinPaymentType]   TINYINT  NULL,
    [MinPaymentAmount] MONEY    NULL,
    CONSTRAINT [PK_StoreOrderStats_BusinessEntityID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC)
);


GO
ALTER TABLE [Sales].[StoreOrderStats] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

