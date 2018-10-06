
CREATE PROCEDURE [Controller].[ETLPrepareFactTransformTable](
	@ModelName nvarchar(128)
)
AS
BEGIN

    --AUDIT START
	DECLARE @ExecutionId BIGINT;
	SELECT @ExecutionId = ISNULL(MAX([execution_id]), - 1) FROM [SSISDB].[catalog].[executions] WHERE package_name = 'Controller.dtsx'	AND STATUS = 2;

	IF NOT EXISTS (SELECT * FROM [Audit].[ModelExecutionStats] WHERE ExecutionID = @ExecutionId AND [ModelTable] = N'Fact' + @ModelName)
	BEGIN
	  INSERT INTO [Audit].[ModelExecutionStats] ([ExecutionID],[ModelTable],[ChangedKeyCount],[StartTime])
	  SELECT TOP 1 @ExecutionId
			 ,N'Fact' + @ModelName
			 ,[ChangedKeys].[ChangedKeysCount]
			 ,GETDATE()
	  FROM [Audit].[ExecutionChangedKeyCounts] [ChangedKeys]
	  WHERE [ChangedKeys].[ExecutionID] = @ExecutionId
	  AND [ChangedKeys].[ChangedKeysTable] = N'Fact' + @ModelName + 'ChangedKeys'
	END;
	--AUDIT END

	PRINT N'@ModelName: ' + ISNULL(@ModelName,N'NULL');

	IF(@ModelName IS NULL)
		BEGIN
			RAISERROR(50001,16,1,'@ModelName');
			RETURN;
		END

	DECLARE @FQTransformTableName nvarchar(256) = N'[Transform].[Fact' + @ModelName + N'Changes]';

	-- ensure that the transform table is empty
	DECLARE @PrepareStatement nvarchar(512) = N'TRUNCATE TABLE ' + @FQTransformTableName;

	EXEC(@PrepareStatement);

	RETURN(0);
END
