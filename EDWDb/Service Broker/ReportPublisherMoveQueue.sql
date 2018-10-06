CREATE QUEUE [Controller].[ReportPublisherMoveQueue]
    WITH ACTIVATION (STATUS = ON, PROCEDURE_NAME = [Controller].[ReportPublisherProcessMoveQueue], MAX_QUEUE_READERS = 1, EXECUTE AS OWNER);

