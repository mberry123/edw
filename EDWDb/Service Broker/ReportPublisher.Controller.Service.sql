CREATE SERVICE [ReportPublisher.Controller.Service]
    AUTHORIZATION [dbo]
    ON QUEUE [Controller].[ReportPublisherControllerQueue]
    ([//ReportPublisher/Contract/Asynchronous], [//ReportPublisher/Contract/Synchronous]);

