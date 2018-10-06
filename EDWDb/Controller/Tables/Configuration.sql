CREATE TABLE [Controller].[Configuration] (
    [KeyName]        NVARCHAR (128) NOT NULL,
    [KeyValue]       NVARCHAR (256) NULL,
    [KeyDescription] NVARCHAR (256) NOT NULL,
    PRIMARY KEY CLUSTERED ([KeyName] ASC)
);

