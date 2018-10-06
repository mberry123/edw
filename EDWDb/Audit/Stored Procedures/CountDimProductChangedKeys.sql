CREATE PROCEDURE [Audit].[CountDimProductChangedKeys]
AS
BEGIN
DECLARE @ExecutionId BIGINT;
SELECT @ExecutionId = ISNULL(MAX([execution_id]), - 1) FROM [SSISDB].[catalog].[executions] WHERE package_name = 'Controller.dtsx'	AND STATUS = 2;

INSERT INTO [Audit].[ExecutionChangedKeyCounts]
SELECT  ISNULL(@ExecutionId, -1) AS 'ExecutionID'
	,'DimProductChangedKeys' AS ChangedKeysTable
	,COUNT(*) AS 'ChangedKeysCount'
	,GETDATE()
FROM [Transform].[DimProductChangedKeys]
END

