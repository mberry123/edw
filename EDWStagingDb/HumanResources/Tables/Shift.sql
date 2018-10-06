CREATE TABLE [HumanResources].[Shift] (
    [ShiftID]      TINYINT      IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]         [dbo].[Name] NOT NULL,
    [StartTime]    TIME (7)     NOT NULL,
    [EndTime]      TIME (7)     NOT NULL,
    [ModifiedDate] DATETIME     NOT NULL,
    CONSTRAINT [PK_Shift_ShiftID] PRIMARY KEY CLUSTERED ([ShiftID] ASC)
);


GO
ALTER TABLE [HumanResources].[Shift] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);

