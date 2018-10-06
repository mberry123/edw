
CREATE PROCEDURE [Controller].[ReportPublisherProcessConsolidateQueue]
AS
BEGIN
	EXEC [Controller].[ReportPublisherProcessControllerChildQueue] @QueueID = 'Consolidate';
END

