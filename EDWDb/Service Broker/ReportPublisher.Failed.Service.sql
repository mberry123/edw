CREATE SERVICE [ReportPublisher.Failed.Service]
    AUTHORIZATION [dbo]
    ON QUEUE [Controller].[ReportPublisherFailedQueue]
    ([//ReportPublisher/Contract/Synchronous]);

