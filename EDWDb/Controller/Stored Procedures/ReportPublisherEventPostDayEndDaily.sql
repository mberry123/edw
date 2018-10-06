
CREATE PROCEDURE [Controller].[ReportPublisherEventPostDayEndDaily](
	@ScheduleEventDate date = NULL OUTPUT
)
AS
BEGIN
	DECLARE @SystemDate date = CAST([Controller].[fnGetExecutionState]('ICSSystemDateLoaded') AS date);

	-- the event occurs every day but we must wait till the the start of the next day
	-- (i.e. after day end has completed) before publishing the reports
	-- as long as the reports query the day-end snapshot, no data from the next day will be included
	DECLARE @PreviousSystemDate date = DATEADD(DAY,-1,@SystemDate);

	SET @ScheduleEventDate = @PreviousSystemDate; -- i.e. The latest ICS Day End date that has been loaded
END;


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'This procedure will return the previous (post-day-end) ICS System Date that has been loaded.', @level0type = N'SCHEMA', @level0name = N'Controller', @level1type = N'PROCEDURE', @level1name = N'ReportPublisherEventPostDayEndDaily';

