﻿CREATE TABLE [Production].[ProductListPriceHistory] (
    [ProductID]    INT      NOT NULL,
    [StartDate]    DATETIME NOT NULL,
    [EndDate]      DATETIME NULL,
    [ListPrice]    MONEY    NOT NULL,
    [ModifiedDate] DATETIME NOT NULL,
    CONSTRAINT [PK_ProductListPriceHistory_ProductID_StartDate] PRIMARY KEY CLUSTERED ([ProductID] ASC, [StartDate] ASC)
);


GO
ALTER TABLE [Production].[ProductListPriceHistory] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

