CREATE TABLE [Model].[DimDescription] (
    [DescriptionKey]       INT           CONSTRAINT [DF_DimDescription_DescriptionKey] DEFAULT (NEXT VALUE FOR [Controller].[DimDescriptionKey]) NOT NULL,
    [ExecutionID]          BIGINT        NOT NULL,
    [SCDBitmap]            INT           NOT NULL,
    [StartDate]            DATETIME      NOT NULL,
    [EndDate]              DATETIME      NULL,
    [IsLateArrivingMember] BIT           NOT NULL,
    [DescriptionCode]      VARCHAR (64)  DEFAULT ('') NOT NULL,
    [DescriptionTypeCode]  VARCHAR (64)  DEFAULT ('') NOT NULL,
    [Description]          VARCHAR (256) DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_DimDescription_DescriptionKey] PRIMARY KEY CLUSTERED ([DescriptionKey] ASC),
    CONSTRAINT [AK_DimDescription_AlternateKey] UNIQUE NONCLUSTERED ([DescriptionCode] ASC, [DescriptionTypeCode] ASC, [EndDate] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'TableLoadOrder', @value = N'6', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimDescription';


GO
EXECUTE sp_addextendedproperty @name = N'TableType', @value = N'HD', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimDescription';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimDescription', @level2type = N'COLUMN', @level2name = N'DescriptionKey';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimDescription', @level2type = N'COLUMN', @level2name = N'ExecutionID';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimDescription', @level2type = N'COLUMN', @level2name = N'SCDBitmap';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimDescription', @level2type = N'COLUMN', @level2name = N'StartDate';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimDescription', @level2type = N'COLUMN', @level2name = N'EndDate';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimDescription', @level2type = N'COLUMN', @level2name = N'IsLateArrivingMember';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'BK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimDescription', @level2type = N'COLUMN', @level2name = N'DescriptionCode';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'BK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimDescription', @level2type = N'COLUMN', @level2name = N'DescriptionTypeCode';


GO
EXECUTE sp_addextendedproperty @name = N'AttributeType', @value = N'CV', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimDescription', @level2type = N'COLUMN', @level2name = N'Description';

