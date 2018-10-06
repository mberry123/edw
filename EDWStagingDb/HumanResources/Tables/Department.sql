CREATE TABLE [HumanResources].[Department] (
    [DepartmentID] SMALLINT      IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]         [dbo].[Name]  NOT NULL,
    [GroupName]    NVARCHAR (50) NOT NULL,
    [ModifiedDate] DATETIME      NOT NULL,
    CONSTRAINT [PK_Department_DepartmentID] PRIMARY KEY CLUSTERED ([DepartmentID] ASC)
);


GO
ALTER TABLE [HumanResources].[Department] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

