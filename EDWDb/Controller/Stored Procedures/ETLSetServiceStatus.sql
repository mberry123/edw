
CREATE PROCEDURE [Controller].[ETLSetServiceStatus](
	@ETLServiceStatus varchar(8) -- Enabled|Disabled
)
AS
BEGIN
	SET NOCOUNT ON;

	-- save the service state
	EXEC [Controller].[SaveExecutionState] @PropertyID = 'ETLServiceStatus', @PropertyValue = @ETLServiceStatus;
	PRINT N'ETL Service is ' + @ETLServiceStatus;

	-- set job enabled status accordingly
	DECLARE @JobStatus bit = (CASE @ETLServiceStatus WHEN 'Enabled' THEN 1 ELSE 0 END);
	DECLARE @Environment VARCHAR(64) = (select @@servername);
	DECLARE @Sysname VARCHAR(64) = (
		SELECT 	CASE WHEN @Environment = 'DLC-VMBR-SQL-01\EDW' THEN 
		     'EDWDb%'
		ELSE
			 'EDWDb - ETL%'
		END
		)
    PRINT @Environment
	PRINT @Sysname

	DECLARE C_EDW_JOBS CURSOR FAST_FORWARD FOR
	(
	SELECT [name]
		FROM msdb.dbo.sysjobs
		WHERE  
		
		    ([name] LIKE CAST(@Sysname AS sysname))
			AND([name] <> CAST(N'EDWDb - ETL (Service Status)' AS sysname))
			AND([name] <> CAST(N'EDWDb - Export (Internal Letters Archive)' AS sysname))
			AND([name] <> CAST(N'EDWDb - Export (Outsourced Letters)' AS sysname))
			AND([name] <> CAST(N'EDWDb - Export (RC Statements)' AS sysname))
	);
	OPEN C_EDW_JOBS;
	DECLARE @JobName SYSNAME;
	FETCH NEXT FROM C_EDW_JOBS INTO @JobName;

    PRINT @JobName

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		-- disable the job (we could potentially stop the jobs too - needs some thought though :-|)
		EXEC [msdb].[dbo].sp_update_job @job_name = @JobName, @enabled = @JobStatus;
		PRINT N'Job "' + @JobName + '" has been ' + @ETLServiceStatus;

		-- try and start the job
		IF (@ETLServiceStatus = 'Enabled')
		AND(@JobName LIKE CAST(N'%Controller%' AS sysname))
		BEGIN
			EXEC [msdb].[dbo].sp_start_job @job_name = @JobName;
		END

		FETCH NEXT FROM C_EDW_JOBS INTO @JobName;
	END
	CLOSE C_EDW_JOBS;
	DEALLOCATE C_EDW_JOBS;

	RETURN(0);
END;
