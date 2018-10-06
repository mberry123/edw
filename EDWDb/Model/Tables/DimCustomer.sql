CREATE TABLE [Model].[DimCustomer] (
    [CustomerKey]                 INT           CONSTRAINT [DF_DimCustomer_CustomerKey] DEFAULT (NEXT VALUE FOR [Controller].[DimCustomerKey]) NOT NULL,
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
    [CustomerEmailAddress]        NVARCHAR (50) NULL,
    [CustomerAnualIncome]         VARCHAR (64)  NULL,
    [CustomerTotalChildren]       INT           NULL,
    [CustomerChildrenAtHome]      INT           NULL,
    [CustomerEducation]           VARCHAR (64)  NULL,
    [CustomerOccupation]          VARCHAR (64)  NULL,
    [CustomerIsHomeOwner]         BIT           NULL,
    [CustomerNumberOfVehicles]    INT           NULL,
    [CustomerFirstPurchaseDate]   DATE          NULL,
    [CustomerCommuteDistance]     VARCHAR (64)  NULL,
    [Version]                     INT           DEFAULT ((1)) NULL,
    CONSTRAINT [PK_DimCustomer] PRIMARY KEY CLUSTERED ([CustomerKey] ASC),
    CONSTRAINT [AK_DimCustomer] UNIQUE NONCLUSTERED ([CustomerID] ASC, [EndDate] ASC)
);


GO
CREATE TRIGGER [Model].[IncrementVersion_DimCustomer] 
ON [Model].[DimCustomer]
AFTER INSERT, UPDATE AS
BEGIN
WITH UpdatedRows
AS
(
SELECT DISTINCT [CustomerID] FROM INSERTED
)
,Versions
AS
(
SELECT [Customer].[CustomerID]
       ,[Customer].[StartDate]
	   ,RANK() OVER (PARTITION BY [Customer].[CustomerID] ORDER BY [Customer].[StartDate]) AS 'Rank'
FROM [Model].[DimCustomer] Customer
INNER JOIN UpdatedRows
 ON ([Customer].[CustomerID] = [UpdatedRows].[CustomerID])
)
UPDATE Customer
SET [Version] = [Versions].[Rank]
FROM [Model].[DimCustomer] Customer
INNER JOIN [Versions]
	ON ([Customer].[CustomerID] = [Versions].[CustomerID]
	AND [Customer].[StartDate] = [Versions].[StartDate])
 END





GO
EXECUTE sp_addextendedproperty @name = N'TableLoadOrder', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer';


GO
EXECUTE sp_addextendedproperty @name = N'TableType', @value = N'HD', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerKey';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'ExecutionID';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'SCDBitmap';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'StartDate';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'EndDate';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'IsLateArrivingMember';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'BK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerID';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerTitle';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerFirstName';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerMiddleName';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerLastName';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerDOB';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerMaritalStatus';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerGender';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerAddressLine1';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerAddressLine2';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerCity';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerStateProvinceCode';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerStateProvinceName';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerCountryRegionCode';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerCountryRegionName';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerSalesTerritoryName';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerSalesTerritoryGroup';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerPostCode';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerPhone';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerEmailAddress';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerAnualIncome';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerTotalChildren';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerChildrenAtHome';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerEducation';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerOccupation';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerIsHomeOwner';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerNumberOfVehicles';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerFirstPurchaseDate';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimCustomer', @level2type = N'COLUMN', @level2name = N'CustomerCommuteDistance';

