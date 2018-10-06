
CREATE PROCEDURE [Controller].[ETLPrepareModelEntityTransformTable](
	@ModelEntityName nvarchar(64)
	,@ModelEntityType nvarchar(16)
)
AS
BEGIN

    --AUDIT START
	DECLARE @ExecutionId BIGINT;
	SELECT @ExecutionId = ISNULL(MAX([execution_id]), - 1) FROM [SSISDB].[catalog].[executions] WHERE package_name = 'Controller.dtsx'	AND STATUS = 2;

	IF NOT EXISTS (SELECT * FROM [Audit].[ModelExecutionStats] WHERE ExecutionID = @ExecutionId AND [ModelTable] = @ModelEntityType + @ModelEntityName)
	BEGIN
	  INSERT INTO [Audit].[ModelExecutionStats] ([ExecutionID],[ModelTable],[ChangedKeyCount],[StartTime])
	  SELECT TOP 1 @ExecutionId
			 ,@ModelEntityType + @ModelEntityName
			 ,[ChangedKeys].[ChangedKeysCount]
			 ,GETDATE()
	  FROM [Audit].[ExecutionChangedKeyCounts] [ChangedKeys]
	  WHERE [ChangedKeys].[ExecutionID] = @ExecutionId
	  AND [ChangedKeys].[ChangedKeysTable] = @ModelEntityType + @ModelEntityName + 'ChangedKeys'
	END;
	--AUDIT END

	PRINT N'@ModelEntityName: ' + ISNULL(@ModelEntityName,N'NULL');

	IF(@ModelEntityName IS NULL)
		BEGIN
			RAISERROR(50001,16,1,'@ModelEntityName');
			RETURN;
		END

	DECLARE @FQTransformTableName nvarchar(132) = N'[Transform].[' + @ModelEntityType + @ModelEntityName + N'Changes]';

	-- ensure transform table is empty
	DECLARE @PrepareStatement nvarchar(512) = N'TRUNCATE TABLE ' + @FQTransformTableName;

	--PRINT @PrepareStatement
	EXEC(@PrepareStatement);

	RETURN(0);
END
