CREATE CONTRACT [//ReportPublisher/Contract/Asynchronous]
    AUTHORIZATION [dbo]
    ([//ReportPublisher/Message/Complete] SENT BY TARGET, [//ReportPublisher/Message/Start] SENT BY INITIATOR);

