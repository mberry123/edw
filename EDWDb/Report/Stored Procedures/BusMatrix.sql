

CREATE PROCEDURE [Report].[BusMatrix]
--WITH EXECUTE AS OWNER -- required as not everyone has access to the [sys] tables
AS

SELECT  
    [tab1].[name]	AS 'table',
    [tab2].[name]	AS 'referenced_table',
	'X'				AS 'Relationship'
FROM [sys].[foreign_key_columns] [fkc]
INNER JOIN [sys].[tables] [tab1]
    ON [tab1].[object_id] = [fkc].[parent_object_id]
INNER JOIN [sys].[schemas] [sch]
    ON [tab1].[schema_id] = [sch].[schema_id]
INNER JOIN [sys].[columns] [col1]
    ON [col1].[column_id] = [parent_column_id] 
	AND [col1].[object_id] = [tab1].[object_id]
INNER JOIN [sys].[tables] [tab2]
    ON [tab2].[object_id] = [fkc].[referenced_object_id]
WHERE [sch].[name] = 'Model'
ORDER BY [table]
