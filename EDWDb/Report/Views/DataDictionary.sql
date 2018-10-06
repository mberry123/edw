
CREATE VIEW [Report].[DataDictionary]
AS

WITH DataDictionary AS (
       SELECT
              REPLACE(vw.[name],'View','') AS 'TableName'
			  ,sch.name as [schema]
			  ,CAST(CAST(ext.[value] AS nvarchar(4000)) AS xml) AS 'ColumnProperties'
			  ,(
			  typ.[name] + N' '
			  + (CASE
					WHEN (RIGHT(typ.[name],4) = N'char') THEN N'(' + CAST(col.[max_length] AS nvarchar) + N')'
					WHEN (typ.[name] IN ('numeric','decimal')) THEN N'(' + CAST(col.[precision] AS nvarchar) + N',' + CAST(col.[scale] AS nvarchar) + N')'
					ELSE N''
			     END)
		)AS 'DataType'
       FROM sys.schemas AS sch
       INNER JOIN sys.views AS vw
              ON (sch.[schema_id] = vw.[schema_id])
       INNER JOIN sys.columns AS col
              ON (vw.[object_id] = col.[object_id])
	   INNER JOIN sys.types typ
			  ON (col.user_type_id = typ.user_type_id)
       LEFT JOIN sys.extended_properties AS ext
              ON (ext.[major_id] = col.[object_id])
              AND(ext.[minor_id] = col.[column_id])
              AND(ext.[name] = 'DataDictionary')
       WHERE  (sch.[name] IN ('Model','Report','View')) 
             -- AND(REPLACE(vw.[name],'View','') = @TableName)
)
SELECT
       [ColumnProperties],
	   [DataDictionary].[schema],
       [TableName] as 'Table Name',
	   [DataType] as 'Data_Type',
       [ColumnProperties].value('(//Name)[1]','varchar(512)') AS 'Column Name',
       [ColumnProperties].value('(//Description)[1]','varchar(512)') AS 'Description',
       [ColumnProperties].value('(//IsLogic)[1]','varchar(3)') AS 'IsLogic',
       REPLACE(
              (
                     SELECT
                           [ColumnProperties].query('for $name in //LegacyName return concat("[",string(($name/text())[1]),"]")')
                     FOR XML PATH('')
              )
              ,'[]','') AS 'LegacyNames',
       (
              N'[' + 
                        (SELECT    ColumnSources.Sources.query('.') FOR XML PATH, TYPE).value('(//System)[1]','sysname') + N'].[' +
                        (SELECT    ColumnSources.Sources.query('.') FOR XML PATH, TYPE).value('(//Table)[1]','sysname') + N'].[' +
                        (SELECT    ColumnSources.Sources.query('.') FOR XML PATH, TYPE).value('(//Column)[1]','sysname') + N']'
       ) AS 'SourceColumn',
                                         (SELECT    ColumnSources.Sources.query('.') FOR XML PATH, TYPE).value('(//System)[1]','sysname') as 'System',
                        (SELECT    ColumnSources.Sources.query('.') FOR XML PATH, TYPE).value('(//Table)[1]','sysname') as 'Table',
                        (SELECT    ColumnSources.Sources.query('.') FOR XML PATH, TYPE).value('(//Column)[1]','sysname') as 'Column',
          CASE 
                     WHEN [ColumnProperties].value('(//IsLogic)[1]','varchar(3)') not in ('0','N/A')  
                     THEN'$/BICC/Data Warehouse/Databases/EDWDb/Schema Objects/Schemas/Transform/Views/' + tablename + 'ChangesView.sql'
                     ELSE 'IsNotLogic' 
              END as 'LogicLocation',
              
         CASE 
              WHEN TableName NOT IN ('DimDate','DimTime')
              THEN'http://'+'mcs-vmbr-tfs-01:8080/tfs/DLC/BICC/Developer%20Team/_VersionControl#path=%24%2FBICC%2FData+Warehouse%2FDatabases%2FEDWDb%2FSchema+Objects%2FSchemas%2FTransform%2FViews%2F'
              +Tablename+'Changesview' +
              '.sql&_a=contents' ELSE '' END as 'LogicLocationlink'

FROM DataDictionary
CROSS APPLY [ColumnProperties].nodes('//Source') AS ColumnSources(Sources)
WHERE LEFT([ColumnProperties].value('(//Description)[1]','varchar(512)'),1) <> '#';

