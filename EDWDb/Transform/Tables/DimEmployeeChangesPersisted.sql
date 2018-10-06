CREATE TABLE [Transform].[DimEmployeeChangesPersisted] (
    [EmployeeCode]                INT          NOT NULL,
    [EmployeeDepartment]          VARCHAR (50) NOT NULL,
    [EmployeeDepartmentGroupName] VARCHAR (50) NOT NULL,
    [EmployeeDepartmentStartDate] DATE         NOT NULL,
    [EmployeeTitle]               VARCHAR (8)  NULL,
    [EmployeeFirstName]           VARCHAR (50) NOT NULL,
    [EmployeeMiddleName]          VARCHAR (50) NULL,
    [EmployeeLastName]            VARCHAR (50) NOT NULL,
    [EmployeeSuffix]              VARCHAR (10) NULL,
    [EmployeeJobTitle]            VARCHAR (50) NOT NULL,
    [EmployeePhoneNumber]         VARCHAR (25) NULL,
    [EmployeePhoneNumberType]     VARCHAR (50) NULL,
    [EmployeeEmailAddress]        VARCHAR (50) NOT NULL,
    [EmployeeEmailPromotion]      INT          NOT NULL,
    [EmployeeAddressLine1]        VARCHAR (50) NULL,
    [EmployeeAddressLine2]        VARCHAR (50) NULL,
    [EmployeeCity]                VARCHAR (50) NOT NULL,
    [EmployeeStateProvinceName]   VARCHAR (50) NOT NULL,
    [EmployeePostalCode]          VARCHAR (50) NOT NULL,
    [EmployeeCountryRegionName]   VARCHAR (50) NOT NULL
);

