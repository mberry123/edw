CREATE TABLE [Transform].[DimDescriptionChanges] (
    [DescriptionKey]       INT           NOT NULL,
    [ExecutionID]          BIGINT        NOT NULL,
    [SCDBitmap]            INT           NOT NULL,
    [StartDate]            DATETIME      NOT NULL,
    [EndDate]              DATETIME      NULL,
    [IsLateArrivingMember] BIT           NOT NULL,
    [DescriptionCode]      VARCHAR (64)  DEFAULT ('') NOT NULL,
    [DescriptionTypeCode]  VARCHAR (64)  DEFAULT ('') NOT NULL,
    [Description]          VARCHAR (256) DEFAULT ('') NOT NULL
);

