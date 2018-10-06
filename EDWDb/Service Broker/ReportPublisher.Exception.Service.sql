CREATE SERVICE [ReportPublisher.Exception.Service]
    AUTHORIZATION [dbo]
    ON QUEUE [Controller].[ReportPublisherExceptionQueue]
    ([//ReportPublisher/Contract/Synchronous]);

