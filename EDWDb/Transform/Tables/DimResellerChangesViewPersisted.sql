﻿CREATE TABLE [Transform].[DimResellerChangesViewPersisted] (
    [ResellerCity]                 NVARCHAR (30)   NULL,
    [ResellerStateProvinceCode]    NCHAR (3)       NULL,
    [ResellerStateProvinceName]    NVARCHAR (50)   NULL,
    [ResellerCountryRegionCode]    NVARCHAR (3)    NULL,
    [ResellerCountryRegionName]    NVARCHAR (50)   NULL,
    [ResellerPostalCode]           NVARCHAR (15)   NULL,
    [ResellerSalesTerritoryRegion] NVARCHAR (50)   NULL,
    [ResellerSalesTerritoryGroup]  NVARCHAR (50)   NULL,
    [ResellerID]                   VARCHAR (10)    NULL,
    [ResellerPhone]                NVARCHAR (25)   NULL,
    [ResellerBusinessType]         NVARCHAR (50)   NULL,
    [ResellerResellerName]         NVARCHAR (50)   NULL,
    [ResellerNumberEmployees]      INT             NULL,
    [ResellerOrderFrequency]       CHAR (1)        NULL,
    [ResellerOrderMonth]           INT             NULL,
    [ResellerFirstOrderYear]       INT             NULL,
    [ResellerLastOrderYear]        INT             NULL,
    [ResellerProductLine]          NVARCHAR (50)   NULL,
    [ResellerAddressLine1]         NVARCHAR (60)   NULL,
    [ResellerAddressLine2]         NVARCHAR (60)   NULL,
    [ResellerAnnualSales]          DECIMAL (18, 2) NULL,
    [ResellerBankName]             NVARCHAR (50)   NULL,
    [ResellerMinPaymentType]       INT             NULL,
    [ResellerMinPaymentAmount]     DECIMAL (38, 2) NULL,
    [ResellerAnnualRevenue]        DECIMAL (18, 2) NULL,
    [ResellerYearOpened]           INT             NULL
);
