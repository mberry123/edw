
CREATE PROCEDURE [Controller].[ETLTransformDailyUpdate](
	@DebugOnly bit = 0
)
AS
BEGIN
	DECLARE @ReturnCode int = 0;

	BEGIN TRY

		DECLARE C_DAILYUPDATE_PROCS CURSOR FAST_FORWARD FOR (
		SELECT
			'[Transform].[' + objname + ']' AS 'ProcedureName'
			,CAST([value] AS int) AS 'ExecutionOrder'
		FROM fn_listextendedproperty (NULL, 'schema', 'Transform', 'Procedure', default, NULL, NULL)
		WHERE  ([name] = 'DailyUpdateExecutionOrder')
			AND(CAST([value] AS int) > 0)
		) ORDER BY
			[ExecutionOrder]
		OPEN C_DAILYUPDATE_PROCS;
		DECLARE @ProcedureName sysname, @ExecutionOrder int;
		FETCH NEXT FROM C_DAILYUPDATE_PROCS INTO @ProcedureName, @ExecutionOrder;
		WHILE (@@FETCH_STATUS = 0)
			BEGIN
				PRINT N'Executing daily update procedure: ' + @ProcedureName;

				IF(@DebugOnly = 0)
					EXEC(@ProcedureName);

				FETCH NEXT FROM C_DAILYUPDATE_PROCS INTO @ProcedureName, @ExecutionOrder;
			END
		CLOSE C_DAILYUPDATE_PROCS;
		DEALLOCATE C_DAILYUPDATE_PROCS;

		-- Save the last ICS load date as a daily update high date boundary
		DECLARE @ICSSystemDateLoaded varchar(256) = CAST([Controller].[fnGetExecutionState]('ICSSystemDateLoaded') AS varchar(256));

		EXEC [Controller].[SaveExecutionState] @PropertyID = 'LastDailyUpdateDate',
			@PropertyValue = @ICSSystemDateLoaded;

	END TRY
	BEGIN CATCH
		SET @ReturnCode = ERROR_NUMBER();

		THROW;
	END CATCH

	RETURN(@ReturnCode);
END
