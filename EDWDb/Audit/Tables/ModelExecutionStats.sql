CREATE TABLE [Audit].[ModelExecutionStats] (
    [ExecutionID]     BIGINT       NULL,
    [ModelTable]      VARCHAR (64) NULL,
    [ChangedKeyCount] INT          NULL,
    [UpdateCount]     INT          NULL,
    [InsertCount]     INT          NULL,
    [StartTime]       DATETIME     NULL,
    [EndTime]         DATETIME     NULL
);

