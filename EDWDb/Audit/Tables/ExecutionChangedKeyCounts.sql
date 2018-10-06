CREATE TABLE [Audit].[ExecutionChangedKeyCounts] (
    [ExecutionID]      BIGINT        NULL,
    [ChangedKeysTable] VARCHAR (128) NULL,
    [ChangedKeysCount] INT           NULL,
    [ChangeDateTime]   DATETIME      NULL
);

