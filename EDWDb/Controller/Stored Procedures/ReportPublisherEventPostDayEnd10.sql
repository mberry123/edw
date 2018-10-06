
CREATE PROCEDURE [Controller].[ReportPublisherEventPostDayEnd10](
	@ScheduleEventDate date = NULL OUTPUT
)
AS
BEGIN
	DECLARE @SystemDate date = CAST([Controller].[fnGetExecutionState]('ICSSystemDateLoaded') AS date);


	DECLARE @SystemDateDayOfMonth int = DATEPART(DAY,@SystemDate);

	IF (@SystemDateDayOfMonth = 10)
		SET @ScheduleEventDate = @SystemDate; 
	ELSE
		SET @ScheduleEventDate = NULL; -- i.e. the event has not occurred
END


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'This procedure returns the current ICS System Date if it is the 10th day of the month.', @level0type = N'SCHEMA', @level0name = N'Controller', @level1type = N'PROCEDURE', @level1name = N'ReportPublisherEventPostDayEnd10';

