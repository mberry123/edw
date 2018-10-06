CREATE TABLE [Transform].[DimEmployeeChangesViewPersisted] (
    [EmployeeCode]                INT           NULL,
    [EmployeeDepartment]          NVARCHAR (50) NULL,
    [EmployeeDepartmentGroupName] NVARCHAR (50) NULL,
    [EmployeeDepartmentStartDate] DATE          NULL,
    [EmployeeTitle]               NVARCHAR (8)  NULL,
    [EmployeeFirstName]           NVARCHAR (50) NULL,
    [EmployeeMiddleName]          NVARCHAR (50) NULL,
    [EmployeeLastName]            NVARCHAR (50) NULL,
    [EmployeeSuffix]              NVARCHAR (10) NULL,
    [EmployeeJobTitle]            NVARCHAR (50) NULL,
    [EmployeePhoneNumber]         NVARCHAR (25) NULL,
    [EmployeePhoneNumberType]     NVARCHAR (50) NULL,
    [EmployeeEmailAddress]        NVARCHAR (50) NULL,
    [EmployeeEmailPromotion]      INT           NULL,
    [EmployeeAddressLine1]        NVARCHAR (60) NULL,
    [EmployeeAddressLine2]        NVARCHAR (60) NULL,
    [EmployeeCity]                NVARCHAR (30) NULL,
    [EmployeeStateProvinceName]   NVARCHAR (50) NULL,
    [EmployeePostalCode]          NVARCHAR (15) NULL,
    [EmployeeCountryRegionName]   NVARCHAR (50) NULL
);

