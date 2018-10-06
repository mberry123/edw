CREATE SERVICE [ReportPublisher.Consolidate.Service]
    AUTHORIZATION [dbo]
    ON QUEUE [Controller].[ReportPublisherConsolidateQueue]
    ([//ReportPublisher/Contract/Asynchronous]);

