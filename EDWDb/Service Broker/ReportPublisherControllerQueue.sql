CREATE QUEUE [Controller].[ReportPublisherControllerQueue]
    WITH ACTIVATION (STATUS = ON, PROCEDURE_NAME = [Controller].[ReportPublisherProcessControllerQueue], MAX_QUEUE_READERS = 1, EXECUTE AS OWNER);

