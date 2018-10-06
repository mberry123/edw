CREATE TABLE [Controller].[ExecutionState] (
    [PropertyID]    VARCHAR (64)  NOT NULL,
    [PropertyValue] VARCHAR (256) NOT NULL,
    CONSTRAINT [PK_Controller_ExecutionState] PRIMARY KEY CLUSTERED ([PropertyID] ASC)
);

