
CREATE PROCEDURE [Controller].[ReportPublisherProcessRenderQueue]
AS
BEGIN
	EXEC [Controller].[ReportPublisherProcessControllerChildQueue] @QueueID = 'Render';
END

