CREATE SERVICE [ReportPublisher.Start.Service]
    AUTHORIZATION [dbo]
    ON QUEUE [Controller].[ReportPublisherStartQueue];

