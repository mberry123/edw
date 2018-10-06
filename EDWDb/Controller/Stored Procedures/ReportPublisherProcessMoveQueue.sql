
CREATE PROCEDURE [Controller].[ReportPublisherProcessMoveQueue]
AS
BEGIN
	EXEC [Controller].[ReportPublisherProcessControllerChildQueue] @QueueID = 'Move';
END

