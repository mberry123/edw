
CREATE PROCEDURE [Controller].[ReportPublisherEventPostDayEndYearly](
	@ScheduleEventDate date = NULL OUTPUT
)
AS
BEGIN
	DECLARE @SystemDate date = CAST([Controller].[fnGetExecutionState]('ICSSystemDateLoaded') AS date);
	
	-- the event occurs on the last day of the fiscal year but we must wait till the the start of the next year
	-- (i.e. after day end has completed) before publishing the reports
	-- as long as the reports query the day-end snapshot, no data from the next year will be included
	DECLARE @PreviousSystemDate date = DATEADD(DAY,-1,@SystemDate);
	DECLARE @FiscalCalendarStartMonth int = CAST([Controller].[fnGetConfigurationItem]('ReportPublisher.FiscalCalendarStartMonth') AS int);
	DECLARE @FiscalCalendarStartDate date = DATEFROMPARTS(YEAR(@PreviousSystemDate),@FiscalCalendarStartMonth,1);
	DECLARE @FiscalCalendarEndDate date = DATEADD(DAY,-1,@FiscalCalendarStartDate);

	IF(@PreviousSystemDate = @FiscalCalendarEndDate)
		SET @ScheduleEventDate = @PreviousSystemDate;
	ELSE
		SET @ScheduleEventDate = NULL; -- i.e. the event has not occurred
END;


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'This procedure returns the previous (post-day-end) ICS System Date if it is the last day of the fiscal year.', @level0type = N'SCHEMA', @level0name = N'Controller', @level1type = N'PROCEDURE', @level1name = N'ReportPublisherEventPostDayEndYearly';

