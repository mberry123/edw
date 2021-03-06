﻿CREATE TABLE [Transform].[DimResellerChanges] (
    [ResellerKey]                  INT             NOT NULL,
    [ExecutionID]                  BIGINT          NOT NULL,
    [SCDBitmap]                    INT             NOT NULL,
    [StartDate]                    DATETIME        NOT NULL,
    [IsLateArrivingMember]         BIT             NOT NULL,
    [EndDate]                      DATETIME        NULL,
    [ResellerCity]                 NVARCHAR (30)   DEFAULT ('') NOT NULL,
    [ResellerStateProvinceCode]    NVARCHAR (3)    DEFAULT ('') NOT NULL,
    [ResellerStateProvinceName]    NVARCHAR (50)   DEFAULT ('') NOT NULL,
    [ResellerCountryRegionCode]    NVARCHAR (3)    DEFAULT ('') NOT NULL,
    [ResellerCountryRegionName]    NVARCHAR (50)   DEFAULT ('') NOT NULL,
    [ResellerPostalCode]           NVARCHAR (15)   DEFAULT ('') NOT NULL,
    [ResellerSalesTerritoryRegion] NVARCHAR (50)   DEFAULT ('') NOT NULL,
    [ResellerSalesTerritoryGroup]  NVARCHAR (50)   DEFAULT ('') NOT NULL,
    [ResellerID]                   NVARCHAR (15)   NULL,
    [ResellerPhone]                NVARCHAR (25)   NULL,
    [ResellerBusinessType]         VARCHAR (20)    DEFAULT ('') NOT NULL,
    [ResellerResellerName]         NVARCHAR (50)   DEFAULT ('') NOT NULL,
    [ResellerNumberEmployees]      INT             NULL,
    [ResellerOrderFrequency]       CHAR (1)        NULL,
    [ResellerOrderMonth]           INT             NULL,
    [ResellerFirstOrderYear]       INT             NULL,
    [ResellerLastOrderYear]        INT             NULL,
    [ResellerProductLine]          NVARCHAR (50)   NULL,
    [ResellerAddressLine1]         NVARCHAR (60)   NULL,
    [ResellerAddressLine2]         NVARCHAR (60)   NULL,
    [ResellerAnnualSales]          DECIMAL (38, 2) NULL,
    [ResellerBankName]             NVARCHAR (50)   NULL,
    [ResellerMinPaymentType]       INT             NULL,
    [ResellerMinPaymentAmount]     DECIMAL (38, 2) NULL,
    [ResellerAnnualRevenue]        DECIMAL (38, 2) NULL,
    [ResellerYearOpened]           INT             NULL
);

