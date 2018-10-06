CREATE TABLE [Transform].[FactInternetSalesChangedKeys] (
    [OrderDate]          DATETIME NOT NULL,
    [SalesOrderID]       INT      NOT NULL,
    [SalesOrderDetailID] INT      NOT NULL,
    [RevisionNumber]     TINYINT  NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [NCNU_FactInternetSalesChangedKeys]
    ON [Transform].[FactInternetSalesChangedKeys]([OrderDate] ASC, [SalesOrderID] ASC, [RevisionNumber] ASC)
    INCLUDE([SalesOrderDetailID]);

