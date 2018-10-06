CREATE TABLE [Transform].[DimProductChangedKeys] (
    [ProductCode] NVARCHAR (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    CONSTRAINT [PK_DimProductChangedKeys] PRIMARY KEY CLUSTERED ([ProductCode] ASC)
);

