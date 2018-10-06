CREATE TABLE [HumanResources].[Employee] (
    [BusinessEntityID]  INT                 NOT NULL,
    [NationalIDNumber]  NVARCHAR (15)       COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [LoginID]           NVARCHAR (256)      COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [OrganizationNode]  [sys].[hierarchyid] NULL,
    [OrganizationLevel] AS                  ([OrganizationNode].[GetLevel]()),
    [JobTitle]          NVARCHAR (50)       COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [BirthDate]         DATE                NOT NULL,
    [MaritalStatus]     NCHAR (1)           COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Gender]            NCHAR (1)           COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [HireDate]          DATE                NOT NULL,
    [SalariedFlag]      [dbo].[Flag]        NOT NULL,
    [VacationHours]     SMALLINT            NOT NULL,
    [SickLeaveHours]    SMALLINT            NOT NULL,
    [CurrentFlag]       [dbo].[Flag]        NOT NULL,
    [rowguid]           UNIQUEIDENTIFIER    ROWGUIDCOL NOT NULL,
    [ModifiedDate]      DATETIME            NOT NULL,
    CONSTRAINT [PK_Employee_BusinessEntityID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC)
);


GO
ALTER TABLE [HumanResources].[Employee] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

