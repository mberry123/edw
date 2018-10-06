
CREATE FUNCTION [Controller].[fnModelTables](
	@TableName sysname
)
RETURNS TABLE
AS RETURN(
	SELECT
		DbTables.[name] AS 'TableName',
		CAST(TableType.[value] AS char(2)) AS 'TableType',
		CAST(TableLoadOrder.[value] AS int) AS 'TableLoadOrder'
	FROM sys.tables AS DbTables WITH(READUNCOMMITTED)
	LEFT JOIN fn_listextendedproperty (N'TableType',N'Schema','Model',N'Table',@TableName,NULL,NULL) AS TableType
		ON (TableType.[objname] = DbTables.[name] COLLATE DATABASE_DEFAULT)
	LEFT JOIN fn_listextendedproperty (N'TableLoadOrder',N'Schema','Model',N'Table',@TableName,NULL,NULL) AS TableLoadOrder
		ON (TableLoadOrder.[objname] = DbTables.[name] COLLATE DATABASE_DEFAULT)
	WHERE  (DbTables.[schema_id] = SCHEMA_ID(N'Model'))
		AND(DbTables.[name] = @TableName)
)
