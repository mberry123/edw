
CREATE PROCEDURE [Controller].[ETLLogNonChangedKeyTables]
AS
DECLARE @ExecutionId BIGINT;
SELECT @ExecutionId = ISNULL(MAX([execution_id]), - 1) FROM [SSISDB].[catalog].[executions] WHERE package_name = 'Controller.dtsx'	AND STATUS = 2;
WITH NoChangedKeys
AS
(
SELECT t.NAME AS 'ModelTable'
FROM sys.tables AS t
INNER JOIN sys.schemas AS s 
	ON t.[schema_id] = s.[schema_id]
WHERE s.NAME = N'Model'
	AND T.NAME NOT IN (
		'DimDate'
		,'DimTime'
		)

EXCEPT

SELECT REPLACE(t.NAME, 'ChangedKeys', '')
FROM sys.tables AS t
INNER JOIN sys.schemas AS s 
	ON t.[schema_id] = s.[schema_id]
WHERE s.NAME = N'Transform'
	AND t.NAME LIKE '%ChangedKeys'
)

  INSERT INTO [Audit].[ExecutionChangedKeyCounts]
           ([ExecutionID]
           ,[ChangedKeysTable]
           ,[ChangedKeysCount]
           ,[ChangeDateTime])
  SELECT @ExecutionId
         ,ModelTable + 'ChangedKeys'
		 ,-1
		 ,GETDATE()
  FROM NoChangedKeys;
