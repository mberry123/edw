CREATE SERVICE [ReportPublisher.Move.Service]
    AUTHORIZATION [dbo]
    ON QUEUE [Controller].[ReportPublisherMoveQueue]
    ([//ReportPublisher/Contract/Asynchronous]);

