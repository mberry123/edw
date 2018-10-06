CREATE QUEUE [Controller].[ReportPublisherRenderQueue]
    WITH ACTIVATION (STATUS = ON, PROCEDURE_NAME = [Controller].[ReportPublisherProcessRenderQueue], MAX_QUEUE_READERS = 10, EXECUTE AS OWNER);

