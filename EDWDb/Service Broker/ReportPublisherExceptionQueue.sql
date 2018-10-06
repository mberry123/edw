CREATE QUEUE [Controller].[ReportPublisherExceptionQueue]
    WITH ACTIVATION (STATUS = ON, PROCEDURE_NAME = [Controller].[ReportPublisherProcessExceptionQueue], MAX_QUEUE_READERS = 1, EXECUTE AS OWNER);

