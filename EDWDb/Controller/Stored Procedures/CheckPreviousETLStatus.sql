
CREATE PROCEDURE [Controller].[CheckPreviousETLStatus] (
	@ExecutionID INT
	,@LastRunStatus NCHAR(1) OUTPUT
	)
AS
BEGIN
DECLARE @ICSSystemDate DATE;
DECLARE @LastDailyUpdateDate DATE;

SELECT @ICSSystemDate = [PropertyValue] FROM [Controller].[ExecutionState] WHERE [PropertyID] = 'ICSSystemDate';
SELECT @LastDailyUpdateDate = [PropertyValue] FROM [Controller].[ExecutionState] WHERE [PropertyID] = 'LastDailyUpdateDate'

	IF @ICSSystemDate > @LastDailyUpdateDate
	BEGIN
		SELECT @LastRunStatus = '7'
	END
	ELSE
	BEGIN
		SELECT @LastRunStatus = (
				SELECT TOP (1)	[STATUS]
				FROM			[SSISDB].[catalog].[executions]
				WHERE			([package_name] = 'Controller.dtsx')
								AND ([project_name] = 'ETL')
								AND ([execution_id] < @ExecutionID)
				ORDER BY		[end_time] DESC
				)
	END
END;
