
CREATE PROCEDURE [Controller].[ReportPublisherEventPostDayEnd21](
	@ScheduleEventDate date = NULL OUTPUT
)
AS
BEGIN
	DECLARE @SystemDate date = CAST([Controller].[fnGetExecutionState]('ICSSystemDateLoaded') AS date);

	-- the event occurs the 21st day but we must wait till the the start of the next day
	-- (i.e. after day end has completed) before publishing the reports
	-- as long as the reports query the day-end snapshot, no data from the next day will be included
	DECLARE @PreviousSystemDate date = DATEADD(DAY,-1,@SystemDate);
	DECLARE @PreviousSystemDateDayOfMonth int = DATEPART(DAY,@PreviousSystemDate);

	IF (@PreviousSystemDateDayOfMonth = 21)
		SET @ScheduleEventDate = @PreviousSystemDate; 
	ELSE
		SET @ScheduleEventDate = NULL; -- i.e. the event has not occurred
END


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'This procedure returns the previous (post-day-end) ICS System Date if it is the 21st day of the month.', @level0type = N'SCHEMA', @level0name = N'Controller', @level1type = N'PROCEDURE', @level1name = N'ReportPublisherEventPostDayEnd21';

