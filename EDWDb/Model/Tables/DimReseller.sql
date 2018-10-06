CREATE TABLE [Model].[DimReseller] (
    [ResellerKey]                  INT             CONSTRAINT [DF_DimReseller_ResellerKey] DEFAULT (NEXT VALUE FOR [Controller].[DimResellerKey]) NOT NULL,
    [ExecutionID]                  BIGINT          NOT NULL,
    [SCDBitmap]                    INT             NOT NULL,
    [StartDate]                    DATETIME        NOT NULL,
    [EndDate]                      DATETIME        NULL,
    [IsLateArrivingMember]         BIT             NOT NULL,
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
    [ResellerMinPaymentAmount]     DECIMAL (18, 2) NULL,
    [ResellerAnnualRevenue]        DECIMAL (18, 2) NULL,
    [ResellerYearOpened]           INT             NULL,
    CONSTRAINT [PK_DimReseller] PRIMARY KEY CLUSTERED ([ResellerKey] ASC),
    CONSTRAINT [AK_DimReseller] UNIQUE NONCLUSTERED ([ResellerID] ASC, [EndDate] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'TableLoadOrder', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller';


GO
EXECUTE sp_addextendedproperty @name = N'TableType', @value = N'HD', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerKey';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ExecutionID';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'SCDBitmap';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'StartDate';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'EndDate';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'IsLateArrivingMember';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerCity';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerStateProvinceCode';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerStateProvinceName';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerCountryRegionCode';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerCountryRegionName';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerPostalCode';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerSalesTerritoryRegion';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerSalesTerritoryGroup';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'BK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerID';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerPhone';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerBusinessType';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerResellerName';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerNumberEmployees';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerOrderFrequency';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerOrderMonth';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerFirstOrderYear';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerLastOrderYear';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerProductLine';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerAddressLine1';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerAddressLine2';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerAnnualSales';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerBankName';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerMinPaymentType';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerMinPaymentAmount';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerAnnualRevenue';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimReseller', @level2type = N'COLUMN', @level2name = N'ResellerYearOpened';

