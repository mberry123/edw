
CREATE PROCEDURE [Controller].[ReportPublisherExecuteMappedPackage](
	@QueueID nvarchar(64)
	,@ConversationHandle uniqueidentifier
)
AS
BEGIN
	-- set package parameters
	DECLARE @PackageParameters Controller.PackageParametersType;
	INSERT INTO @PackageParameters ([ParameterName], [ParameterValue], [ParameterType], [DataType])
	VALUES
		('LOGGING_LEVEL','0', 50, 'Int32')
		,('ConversationHandle', CAST(@ConversationHandle AS char(36)), 30, 'String');

	-- get SSIS execution parameters
	DECLARE @SolutionFolderName nvarchar(128) = CAST([Controller].[fnGetConfigurationItem](N'ReportPublisher.SSIS.SolutionFolder') AS nvarchar(128))
		,@SSISEnvRef bigint = CAST([Controller].[fnGetConfigurationItem](N'ReportPublisher.SSIS.EnvironmentReference') AS bigint)
		,@ProjectName nvarchar(128) = CAST([Controller].[fnGetConfigurationItem](N'ReportPublisher.SSIS.ProjectName') AS nvarchar(128))
		,@PackageName nvarchar(128) = CAST([Controller].[fnGetConfigurationItem](N'ReportPublisher.SSIS.' + @QueueID + 'PackageName') AS nvarchar(128))
		,@MaxPackageExecutionDuration int = CAST([Controller].[fnGetConfigurationItem](N'ReportPublisher.MaxPackageExecutionDuration') AS int);

	DECLARE @ExecutionID bigint;
	EXEC [Controller].[SSISExecutePackage]
		@SolutionFolderName = @SolutionFolderName,
		@SSISEnvRef = @SSISEnvRef,
		@ProjectName = @ProjectName,
		@PackageName = @PackageName,
		@PackageParameters = @PackageParameters,
		@MaxPackageExecutionDuration = @MaxPackageExecutionDuration,
		@ExecutionID = @ExecutionID OUTPUT,
		@WaitForCompletion = 1;

	RETURN(0);
END;


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'Prepares parameters for and initiates SSIS package execution.', @level0type = N'SCHEMA', @level0name = N'Controller', @level1type = N'PROCEDURE', @level1name = N'ReportPublisherExecuteMappedPackage';

