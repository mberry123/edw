
CREATE PROCEDURE [Model].[ListModelAttributes] (@TableName VARCHAR(64))
AS

SELECT DISTINCT 
	 O.name AS [Object Name]
	,C.name AS 'ColumnName'
	,ep.name
	,ep.value AS [Extended property Code]
	,CASE ep.value
	  WHEN '1' THEN ''
	  WHEN 'BK' THEN 'Business Key'
	  WHEN 'CV' THEN 'Current Value'
	  WHEN 'HD' THEN 'Historical Dimension'
	  WHEN 'HV' THEN 'Historical Value'
	  WHEN 'DD' THEN 'Degenarate Dimension'
	  WHEN 'FA' THEN 'Fully Additive'
	  WHEN 'FK' THEN 'Foreign Key'
	  WHEN 'DC' THEN 'Dimension Currency'
	  WHEN 'NA' THEN 'Non Additive'
	  WHEN 'SA' THEN 'Semi Additive'
	  WHEN 'SK' THEN 'Surrogate Key'
	  WHEN 'AS' THEN 'Accumulating Snapshot'
	  ELSE '' END AS 'Extended Property Description'
FROM sys.extended_properties EP
LEFT JOIN sys.all_objects O
	ON ep.major_id = O.object_id
LEFT JOIN sys.schemas S
	ON O.schema_id = S.schema_id
LEFT JOIN sys.columns AS c
	ON ep.major_id = c.object_id
		AND ep.minor_id = c.column_id
WHERE O.name = @TableName
ORDER BY ep.value
