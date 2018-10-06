CREATE SERVICE [ReportPublisher.Render.Service]
    AUTHORIZATION [dbo]
    ON QUEUE [Controller].[ReportPublisherRenderQueue]
    ([//ReportPublisher/Contract/Asynchronous]);

