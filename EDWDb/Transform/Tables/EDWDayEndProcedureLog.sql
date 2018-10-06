CREATE TABLE [Transform].[EDWDayEndProcedureLog] (
    [ExecutionDateTime] DATETIME       NULL,
    [ProcName]          VARCHAR (255)  NULL,
    [ExecutionResult]   VARCHAR (255)  NULL,
    [ExceptionDetails]  NVARCHAR (MAX) NULL
);

