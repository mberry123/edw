
CREATE PROCEDURE [Controller].[ReportPublisherEventPostDayEndWeekEndingFriday](
	@ScheduleEventDate date = NULL OUTPUT
)
AS
BEGIN
	DECLARE @SystemDate date = CAST([Controller].[fnGetExecutionState]('ICSSystemDateLoaded') AS date);

	-- the event occurs on Friday but we must wait till Saturday 
	-- (i.e. after day end has completed) before publishing the reports
	-- as long as the reports query the day-end snapshot, no data from the Saturday will be included
	DECLARE @PreviousSystemDate date = DATEADD(DAY,-1,@SystemDate);
	DECLARE @PreviousSystemDay varchar(9) = CAST(DATENAME(WEEKDAY,@PreviousSystemDate) AS varchar(9));
	DECLARE @WeekEndDay varchar(9) = 'Friday';

	IF (@PreviousSystemDay = @WeekEndDay) 
		SET @ScheduleEventDate = @PreviousSystemDate;
	ELSE
		SET @ScheduleEventDate = NULL; -- i.e. the event has not occurred
END


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'This procedure returns the previous (post-day-end) ICS System Date if it is a Friday.', @level0type = N'SCHEMA', @level0name = N'Controller', @level1type = N'PROCEDURE', @level1name = N'ReportPublisherEventPostDayEndWeekEndingFriday';

