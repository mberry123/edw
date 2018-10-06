
CREATE PROCEDURE [Controller].[ReportPublisherEventPostDayEndMonthly](
	@ScheduleEventDate date = NULL OUTPUT
)
AS
BEGIN
	DECLARE @SystemDate date = CAST([Controller].[fnGetExecutionState]('ICSSystemDateLoaded') AS date);

	-- the event occurs on the last day of the month but we must wait till the first of the month 
	-- (i.e. after day end has completed) before publishing the reports
	-- as long as the reports query the day-end snapshot, no data from the first will be included
	DECLARE @PreviousSystemDate date = DATEADD(DAY,-1, @SystemDate);
	DECLARE @PreviousSystemDateDayOfMonth int = DATEPART(DAY,@PreviousSystemDate);
	DECLARE @PreviousMonthEndDayOfMonth int = DATEPART(DAY,EOMONTH(@PreviousSystemDate));

	IF (@PreviousSystemDateDayOfMonth = @PreviousMonthEndDayOfMonth) 
		SET @ScheduleEventDate = @PreviousSystemDate;
	ELSE
		SET @ScheduleEventDate = NULL; -- i.e. the event has not occurred
END


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'This procedure returns the previous (post-day-end) ICS System Date if it is a Sunday.', @level0type = N'SCHEMA', @level0name = N'Controller', @level1type = N'PROCEDURE', @level1name = N'ReportPublisherEventPostDayEndMonthly';

