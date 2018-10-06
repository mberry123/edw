
CREATE FUNCTION [Controller].[fnModelColumns](
	@TableName sysname
)
RETURNS TABLE
AS RETURN(
	SELECT
		ModelColumns.[TableName],
		ModelColumns.[ColumnName],
		ModelColumns.[ColumnOrdinal],
		ModelColumns.[IsMetaData],
		ModelColumns.[KeyType],
		ModelColumns.[FactType],
		ModelColumns.[AttributeType],
		ModelColumns.[ColumnType],
		ModelColumns.[IsPrimaryKey],
		ModelColumns.[IsForeignKey],
		ModelColumns.[ReferencedTableName],
		(CASE
			WHEN (ModelColumns.[IsPrimaryKey] = 0) THEN 0
			ELSE
				ROW_NUMBER() OVER(
					PARTITION BY
						ModelColumns.[TableName],
						(CASE
							WHEN (ModelColumns.[IsPrimaryKey] = 0) THEN 0
							ELSE 1
						END)
					ORDER BY
						ModelColumns.[ColumnOrdinal]
				)
		END) AS 'PrimaryKeyIndex',
		(CASE
			WHEN (ModelColumns.[IsForeignKey] = 0) THEN 0
			ELSE
				ROW_NUMBER() OVER(
					PARTITION BY
						ModelColumns.[TableName],
						(CASE
							WHEN (ModelColumns.[IsForeignKey] = 0) THEN 0
							ELSE 1
						END)
					ORDER BY
						ModelColumns.[ColumnOrdinal]
				)
		END) AS 'ForeignKeyIndex',
		(CASE
			WHEN (ModelColumns.[KeyType] IS NULL) THEN 0
			ELSE
				ROW_NUMBER() OVER(
					PARTITION BY
						ModelColumns.[TableName],
						(CASE
							WHEN (ModelColumns.[KeyType] IS NULL) THEN ''
							ELSE ModelColumns.[KeyType]
						END)
					ORDER BY
						ModelColumns.[ColumnOrdinal]
				)
		END) AS 'KeyTypeIndex',
		(CASE
			WHEN (ModelColumns.[FactType] IS NULL) THEN 0
			ELSE
				ROW_NUMBER() OVER(
					PARTITION BY
						ModelColumns.[TableName],
						(CASE
							WHEN (ModelColumns.[FactType] IS NULL) THEN 0
							ELSE 1
						END)
					ORDER BY
						ModelColumns.[ColumnOrdinal]
				)
		END) AS 'FactTypeIndex',
		(CASE
			WHEN (ModelColumns.[AttributeType] IS NULL) THEN 0
			ELSE
				ROW_NUMBER() OVER(
					PARTITION BY
						ModelColumns.[TableName],
						(CASE
							WHEN (ModelColumns.[AttributeType] IS NULL) THEN 0
							ELSE 1
						END),
						ModelColumns.[AttributeType]
					ORDER BY
						ModelColumns.[ColumnOrdinal]
				)
		END) AS 'AttributeTypeIndex',
		(CASE
			WHEN (ModelColumns.[ColumnType] IS NULL) THEN 0
			ELSE
				ROW_NUMBER() OVER(
					PARTITION BY
						ModelColumns.[TableName],
						(CASE
							WHEN (ModelColumns.[ColumnType] IS NULL) THEN 0
							ELSE 1
						END)
					ORDER BY
						ModelColumns.[ColumnOrdinal]
				)
		END) AS 'ColumnTypeIndex'
	FROM (
		SELECT
			ModelTables.[TableName],
			DbColumns.[name] AS 'ColumnName',
			DbColumns.[column_id] AS 'ColumnOrdinal',
			(
				SELECT
					CAST([value] AS bit)
				FROM fn_listextendedproperty (N'IsMetaData',N'Schema','Model',N'Table',OBJECT_NAME(DbColumns.[object_id]),N'Column',DbColumns.[name])
			) AS 'IsMetaData',
			(
				SELECT
					CAST([value] AS nvarchar(16))
				FROM fn_listextendedproperty (N'KeyType',N'Schema','Model',N'Table',OBJECT_NAME(DbColumns.[object_id]),N'Column',DbColumns.[name])
			) AS 'KeyType',
			(
				SELECT
					CAST([value] AS nvarchar(16))
				FROM fn_listextendedproperty (N'FactType',N'Schema','Model',N'Table',OBJECT_NAME(DbColumns.[object_id]),N'Column',DbColumns.[name])
			) AS 'FactType',
			(
				SELECT
					CAST([value] AS nvarchar(16))
				FROM fn_listextendedproperty (N'AttributeType',N'Schema','Model',N'Table',OBJECT_NAME(DbColumns.[object_id]),N'Column',DbColumns.[name])
			) AS 'AttributeType',
			(
				SELECT
					CAST([value] AS nvarchar(16))
				FROM fn_listextendedproperty (N'ColumnType',N'Schema','Model',N'Table',OBJECT_NAME(DbColumns.[object_id]),N'Column',DbColumns.[name])
			) AS 'ColumnType',
			(CASE
				WHEN (IDXColumn.[index_id] IS NOT NULL) THEN 1
				ELSE 0
			END) AS 'IsPrimaryKey',
			(CASE
				WHEN (FKColumns.[parent_column_id] IS NOT NULL) THEN 1
				ELSE 0
			END) AS 'IsForeignKey',
			OBJECT_NAME(FKColumns.[referenced_object_id]) AS 'ReferencedTableName'
		FROM sys.columns AS DbColumns WITH(READUNCOMMITTED)
		INNER JOIN sys.objects AS ObjectDef
			ON (ObjectDef.[object_id] = DbColumns.[object_id])
			AND(ObjectDef.[schema_id] = SCHEMA_ID(N'Model'))
		INNER JOIN [Controller].[fnModelTables](@TableName) AS ModelTables
			ON (ModelTables.[TableName] = OBJECT_NAME(DbColumns.[object_id]))
		LEFT JOIN sys.index_columns AS PKColumn WITH(READUNCOMMITTED)
			ON (PKColumn.[object_id] = DbColumns.[object_id])
			AND(PKColumn.[column_id] = DbColumns.[column_id])
			AND(PKColumn.[index_id] = 1)
		LEFT JOIN sys.indexes AS IDXColumn WITH(READUNCOMMITTED)
			ON (IDXColumn.[index_id] = PKColumn.[index_id])
			AND(IDXColumn.[object_id] = DbColumns.[object_id])
			AND(IDXColumn.[is_primary_key] = 1)
		LEFT JOIN sys.foreign_key_columns AS FKColumns WITH(READUNCOMMITTED)
			ON (FKColumns.[parent_object_id] = DbColumns.[object_id])
			AND(FKColumns.[parent_column_id] = DbColumns.[column_id])
	) AS ModelColumns
)
