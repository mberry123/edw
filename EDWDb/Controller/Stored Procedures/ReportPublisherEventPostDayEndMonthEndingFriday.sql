
CREATE PROCEDURE [Controller].[ReportPublisherEventPostDayEndMonthEndingFriday](
	@ScheduleEventDate date = NULL OUTPUT
)
AS
BEGIN
	DECLARE @SystemDate date = CAST([Controller].[fnGetExecutionState]('ICSSystemDateLoaded') AS date);

	-- the event occurs on the last Friday of the month but we must wait till the last Saturday of the month 
	-- (i.e. after day end has completed) before publishing the reports
	-- as long as the reports query the day-end snapshot, no data from the last Saturday will be included
	DECLARE @PreviousSystemDate date = DATEADD(DAY,-1, @SystemDate);
	DECLARE @LastFridayOfMonth date = [Controller].[fnGetDatePreviousBespokeMonth](@PreviousSystemDate,1,5,1);

	IF (@PreviousSystemDate = @LastFridayOfMonth)
		SET @ScheduleEventDate = @PreviousSystemDate;
	ELSE
		SET @ScheduleEventDate = NULL; -- i.e. the event has not occurred
END


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'This procedure returns the previous (post-day end) ICS System Date if it is the last Friday of the month.', @level0type = N'SCHEMA', @level0name = N'Controller', @level1type = N'PROCEDURE', @level1name = N'ReportPublisherEventPostDayEndMonthEndingFriday';

