﻿CREATE TABLE [Transform].[DimCustomerChanges] (
    [CustomerKey]                 INT           NOT NULL,
    [ExecutionID]                 BIGINT        NOT NULL,
    [SCDBitmap]                   INT           NOT NULL,
    [StartDate]                   DATETIME      NOT NULL,
    [EndDate]                     DATETIME      NULL,
    [IsLateArrivingMember]        BIT           NOT NULL,
    [CustomerID]                  VARCHAR (10)  NOT NULL,
    [CustomerTitle]               NVARCHAR (8)  NULL,
    [CustomerFirstName]           NVARCHAR (50) DEFAULT ('') NOT NULL,
    [CustomerMiddleName]          NVARCHAR (50) NULL,
    [CustomerLastName]            NVARCHAR (50) DEFAULT ('') NOT NULL,
    [CustomerDOB]                 DATE          NULL,
    [CustomerMaritalStatus]       VARCHAR (1)   NULL,
    [CustomerGender]              VARCHAR (1)   NULL,
    [CustomerAddressLine1]        NVARCHAR (60) DEFAULT ('') NOT NULL,
    [CustomerAddressLine2]        NVARCHAR (60) NULL,
    [CustomerCity]                NVARCHAR (30) DEFAULT ('') NOT NULL,
    [CustomerStateProvinceCode]   NCHAR (3)     DEFAULT ('') NOT NULL,
    [CustomerStateProvinceName]   NVARCHAR (50) DEFAULT ('') NOT NULL,
    [CustomerCountryRegionCode]   NVARCHAR (3)  DEFAULT ('') NOT NULL,
    [CustomerCountryRegionName]   NVARCHAR (50) DEFAULT ('') NOT NULL,
    [CustomerSalesTerritoryName]  NVARCHAR (50) DEFAULT ('') NOT NULL,
    [CustomerSalesTerritoryGroup] NVARCHAR (50) DEFAULT ('') NOT NULL,
    [CustomerPostCode]            NVARCHAR (15) DEFAULT ('') NOT NULL,
    [CustomerPhone]               NVARCHAR (25) DEFAULT ('') NOT NULL,
    [CustomerEmailAddress]        NVARCHAR (50) DEFAULT ('') NULL,
    [CustomerAnualIncome]         VARCHAR (64)  DEFAULT ('') NULL,
    [CustomerTotalChildren]       INT           NULL,
    [CustomerChildrenAtHome]      INT           NULL,
    [CustomerEducation]           VARCHAR (64)  NULL,
    [CustomerOccupation]          VARCHAR (64)  NULL,
    [CustomerIsHomeOwner]         BIT           NULL,
    [CustomerNumberOfVehicles]    INT           NULL,
    [CustomerFirstPurchaseDate]   DATE          NULL,
    [CustomerCommuteDistance]     VARCHAR (64)  NULL,
    [Version]                     INT           NULL
);

