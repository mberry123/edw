CREATE TABLE [Controller].[ServiceEventLog] (
    [EventKey]           INT              DEFAULT (NEXT VALUE FOR [Controller].[ReportPublisherLogKey]) NOT NULL,
    [ApplicationName]    NVARCHAR (128)   NOT NULL,
    [ServiceName]        NVARCHAR (128)   NOT NULL,
    [ConversationHandle] UNIQUEIDENTIFIER NOT NULL,
    [EventDateTime]      DATETIME         DEFAULT (getdate()) NOT NULL,
    [EventType]          VARCHAR (64)     NOT NULL,
    [EventStatus]        VARCHAR (64)     NOT NULL,
    [EventDetails]       XML              NULL,
    CONSTRAINT [PK_ServiceEventLog] PRIMARY KEY CLUSTERED ([EventKey] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'# Primary Key for the table generated from a sequence', @level0type = N'SCHEMA', @level0name = N'Controller', @level1type = N'TABLE', @level1name = N'ServiceEventLog', @level2type = N'COLUMN', @level2name = N'EventKey';


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'# The unique name of the Service Broker application logging the event.', @level0type = N'SCHEMA', @level0name = N'Controller', @level1type = N'TABLE', @level1name = N'ServiceEventLog', @level2type = N'COLUMN', @level2name = N'ApplicationName';


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'# The unique name of the Service Broker service logging the event.', @level0type = N'SCHEMA', @level0name = N'Controller', @level1type = N'TABLE', @level1name = N'ServiceEventLog', @level2type = N'COLUMN', @level2name = N'ServiceName';


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'# The Service Broker Conversation Handle active when logging the event.', @level0type = N'SCHEMA', @level0name = N'Controller', @level1type = N'TABLE', @level1name = N'ServiceEventLog', @level2type = N'COLUMN', @level2name = N'ConversationHandle';


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'# The date and time of which the event occured for the report', @level0type = N'SCHEMA', @level0name = N'Controller', @level1type = N'TABLE', @level1name = N'ServiceEventLog', @level2type = N'COLUMN', @level2name = N'EventDateTime';


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'# The type of event the occured.', @level0type = N'SCHEMA', @level0name = N'Controller', @level1type = N'TABLE', @level1name = N'ServiceEventLog', @level2type = N'COLUMN', @level2name = N'EventType';


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'# The status of the event that occured.', @level0type = N'SCHEMA', @level0name = N'Controller', @level1type = N'TABLE', @level1name = N'ServiceEventLog', @level2type = N'COLUMN', @level2name = N'EventStatus';


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'# The details of the event that occured.', @level0type = N'SCHEMA', @level0name = N'Controller', @level1type = N'TABLE', @level1name = N'ServiceEventLog', @level2type = N'COLUMN', @level2name = N'EventDetails';

