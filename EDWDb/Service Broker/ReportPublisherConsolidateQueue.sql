CREATE QUEUE [Controller].[ReportPublisherConsolidateQueue]
    WITH ACTIVATION (STATUS = ON, PROCEDURE_NAME = [Controller].[ReportPublisherProcessConsolidateQueue], MAX_QUEUE_READERS = 1, EXECUTE AS OWNER);

