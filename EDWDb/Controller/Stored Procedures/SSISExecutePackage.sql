
CREATE PROCEDURE [Controller].[SSISExecutePackage](
       @SolutionFolderName nvarchar(128),
       @SSISEnvRef bigint,
       @ProjectName nvarchar(128),
       @PackageName nvarchar(128),
       @PackageParameters PackageParametersType READONLY,
       @MaxPackageExecutionDuration int,
       @ExecutionID bigint OUTPUT,
       @WaitForCompletion bit = 1
)
AS
BEGIN
       DECLARE @StartTime datetime = GETDATE();

       -- instantiate the package
       DECLARE @execution_id bigint;
       EXEC [SSISDB].[catalog].[create_execution]
              @package_name = @PackageName,
              @execution_id = @ExecutionID OUTPUT,
              @folder_name = @SolutionFolderName,
              @project_name = @ProjectName,
              @use32bitruntime = False,
              @reference_id = @SSISEnvRef;

       -- set package parameters
       DECLARE C_PARAMETERS CURSOR FAST_FORWARD FOR(
              SELECT
                     [ParameterName],
                     [ParameterValue],
                     [ParameterType],
                     [DataType]
              FROM @PackageParameters
       );
       DECLARE @ParameterName nvarchar(128), @ParameterValue sql_variant, @ParameterType smallint, @DataType nvarchar(32);
       OPEN C_PARAMETERS;
       FETCH NEXT FROM C_PARAMETERS INTO @ParameterName, @ParameterValue, @ParameterType, @DataType;
       WHILE(@@FETCH_STATUS = 0)
       BEGIN
              IF (@DataType = N'String')
                     BEGIN
                           DECLARE @StringParameterValue nvarchar(4000) = ISNULL(CAST(@ParameterValue AS nvarchar(4000)),N'');
                           EXEC [SSISDB].[catalog].[set_execution_parameter_value]
                                  @execution_id = @ExecutionID,
                                  @object_type = @ParameterType,
                                  @parameter_name = @ParameterName,
                                  @parameter_value = @StringParameterValue;
                     END

              IF (@DataType = N'Int64')
                     BEGIN
                           DECLARE @Int64ParameterValue bigint = ISNULL(CAST(@ParameterValue AS bigint),0);
                           EXEC [SSISDB].[catalog].[set_execution_parameter_value]
                                  @execution_id = @ExecutionID,
                                  @object_type = @ParameterType,
                                  @parameter_name = @ParameterName,
                                  @parameter_value = @Int64ParameterValue;
                     END

              FETCH NEXT FROM C_PARAMETERS INTO @ParameterName, @ParameterValue, @ParameterType, @DataType;
       END
       CLOSE C_PARAMETERS;
       DEALLOCATE C_PARAMETERS;
       
       -- execute the package
       -- cmdshell must be used as the SSIS proc causes a REVERT error
       DECLARE @sqlcmdOutputRows int, @sqlcmdStartStatement nvarchar(512) = N'sqlcmd -S' + @@SERVERNAME +
              ' -E -Q "EXEC [SSISDB].[catalog].[start_execution] @execution_id = ' + CAST(@ExecutionID AS nvarchar) + ';"';
       EXEC xp_cmdshell @sqlcmdStartStatement;
       SET @sqlcmdOutputRows = @@ROWCOUNT;

       -- check the status of things...
       DECLARE @StringExecutionID nvarchar(128) = CAST(@ExecutionID AS nvarchar(128));

       -- did the package start? (sqlcmd should only output 1 record)
       IF (@sqlcmdOutputRows <> 1)
              BEGIN
                     DECLARE @FailedStartErrorNumber int = 50006;
                     DECLARE @FailedStartExceptionMessage nvarchar(2048) = FORMATMESSAGE(@FailedStartErrorNumber,@PackageName,@StringExecutionID);
                     THROW @FailedStartErrorNumber, @FailedStartExceptionMessage, 1;
                     RETURN;
              END

       -- wait for execution to complete
       IF (@WaitForCompletion = 1)
              BEGIN
                     WHILE (1 = 1)
                           BEGIN
                                  -- wait a few secs for stuff to happen
                                  WAITFOR DELAY '00:00:10';

                                  -- get the current execution status
                                  DECLARE @ExecutionStatus int = 0;
                                  SELECT @ExecutionStatus = [status]
                                  FROM [SSISDB].[catalog].[executions]
                                  WHERE  ([execution_id] = @ExecutionID);

                                  -- has it succeeded
                                  IF (@ExecutionStatus = 7)
                                         BEGIN
                                                RETURN;
                                         END
                                  -- has it gone wrong ?
                                  ELSE IF (@ExecutionStatus IN (1,3,4,6)) --created (1), canceled (3), failed (4), ended unexpectedly (6)
                                         BEGIN
                                                DECLARE @FailedExecutionErrorNumber int = 50007;
                                                DECLARE @FailedExecutionExceptionMessage nvarchar(2048) = FORMATMESSAGE(@FailedExecutionErrorNumber,@PackageName,@StringExecutionID);
                                                THROW @FailedExecutionErrorNumber, @FailedExecutionExceptionMessage, 1;
                                                RETURN;
                                         END
                                  -- check if the max duration has been exceeded
                                  ELSE IF (DATEDIFF(second,@StartTime,GETDATE()) > @MaxPackageExecutionDuration)
                                         BEGIN
                                                DECLARE @ExceededDurationErrorNumber int = (CASE @ExecutionStatus
                                                              WHEN 1 THEN 50008 --created
                                                              WHEN 2 THEN 50009 --running
                                                              WHEN 5 THEN 50010 --pending
                                                       END)

                                                DECLARE @ExceededDurationExceptionMessage nvarchar(2048) = FORMATMESSAGE(@ExceededDurationErrorNumber,@PackageName,@StringExecutionID);
                                                THROW @ExceededDurationErrorNumber, @ExceededDurationExceptionMessage, 1;
                                                RETURN;
                                         END
                           END
              END

       RETURN(0);
END
