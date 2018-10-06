CREATE TABLE [Model].[DimEmployee] (
    [EmployeeKey]                 INT          CONSTRAINT [DF_DimEmployee_EmployeeKey] DEFAULT (NEXT VALUE FOR [Controller].[DimEmployeeKey]) NOT NULL,
    [ExecutionID]                 BIGINT       NOT NULL,
    [SCDBitmap]                   INT          NOT NULL,
    [StartDate]                   DATETIME     NOT NULL,
    [EndDate]                     DATETIME     NULL,
    [IsLateArrivingMember]        BIT          NOT NULL,
    [EmployeeCode]                INT          DEFAULT ((-1)) NOT NULL,
    [EmployeeDepartment]          VARCHAR (50) DEFAULT ('') NOT NULL,
    [EmployeeDepartmentGroupName] VARCHAR (50) DEFAULT ('') NOT NULL,
    [EmployeeDepartmentStartDate] DATE         DEFAULT ('01 JAN 1900') NOT NULL,
    [EmployeeTitle]               VARCHAR (8)  NULL,
    [EmployeeFirstName]           VARCHAR (50) DEFAULT ('') NOT NULL,
    [EmployeeMiddleName]          VARCHAR (50) NULL,
    [EmployeeLastName]            VARCHAR (50) DEFAULT ('') NOT NULL,
    [EmployeeSuffix]              VARCHAR (10) NULL,
    [EmployeeJobTitle]            VARCHAR (50) DEFAULT ('') NOT NULL,
    [EmployeePhoneNumber]         VARCHAR (25) NULL,
    [EmployeePhoneNumberType]     VARCHAR (50) NULL,
    [EmployeeEmailAddress]        VARCHAR (50) NULL,
    [EmployeeEmailPromotion]      INT          DEFAULT ((0)) NOT NULL,
    [EmployeeAddressLine1]        VARCHAR (60) DEFAULT ('') NOT NULL,
    [EmployeeAddressLine2]        VARCHAR (60) NULL,
    [EmployeeCity]                VARCHAR (30) DEFAULT ('') NOT NULL,
    [EmployeeStateProvinceName]   VARCHAR (50) DEFAULT ('') NOT NULL,
    [EmployeePostalCode]          VARCHAR (15) DEFAULT ('') NOT NULL,
    [EmployeeCountryRegionName]   VARCHAR (50) DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_DimEmployee] PRIMARY KEY CLUSTERED ([EmployeeKey] ASC),
    CONSTRAINT [AK_DimEmployee] UNIQUE NONCLUSTERED ([EmployeeCode] ASC, [EndDate] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'TableLoadOrder', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee';


GO
EXECUTE sp_addextendedproperty @name = N'TableType', @value = N'HD', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'EmployeeKey';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'ExecutionID';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'SCDBitmap';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'StartDate';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'EndDate';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'IsLateArrivingMember';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'BK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'EmployeeCode';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'EmployeeDepartment';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'EmployeeDepartmentGroupName';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'EmployeeDepartmentStartDate';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'EmployeeTitle';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'EmployeeFirstName';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'EmployeeMiddleName';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'EmployeeLastName';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'EmployeeSuffix';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'EmployeeJobTitle';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'EmployeePhoneNumber';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'EmployeePhoneNumberType';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'EmployeeEmailAddress';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'EmployeeEmailPromotion';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'EmployeeAddressLine1';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'EmployeeAddressLine2';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'EmployeeCity';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'EmployeeStateProvinceName';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'EmployeePostalCode';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'HV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimEmployee', @level2type = N'COLUMN', @level2name = N'EmployeeCountryRegionName';

