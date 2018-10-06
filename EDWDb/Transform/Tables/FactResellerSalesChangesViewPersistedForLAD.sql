CREATE TABLE [Transform].[FactResellerSalesChangesViewPersistedForLAD] (
    [CurrencyKey_DescriptionCode]        VARCHAR (64)  NULL,
    [CurrencyKey_DescriptionTypeCode]    VARCHAR (64)  NULL,
    [EmployeeKey_EmployeeCode]           INT           NULL,
    [ProductKey_ProductCode]             NVARCHAR (25) NULL,
    [PromotionKey_PromotionID]           INT           NULL,
    [ResellerKey_ResellerID]             NVARCHAR (15) NULL,
    [SalesTerritoryKey_SalesTerritoryId] INT           NULL
);

