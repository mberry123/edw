CREATE TABLE [Transform].[FactResellerSalesChangedKeys] (
    [OrderDate]          DATETIME NOT NULL,
    [SalesOrderID]       INT      NOT NULL,
    [SalesOrderDetailID] INT      NOT NULL,
    [RevisionNumber]     TINYINT  NOT NULL
);

