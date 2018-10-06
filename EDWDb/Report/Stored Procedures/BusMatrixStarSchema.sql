

CREATE PROCEDURE [Report].[BusMatrixStarSchema]
(
	@FactTable VARCHAR(256)
)
--WITH EXECUTE AS OWNER -- required as not everyone has access to the [sys] tables
AS

DECLARE @BoxSize INT 
DECLARE @Stretch FLOAT

SET     @BoxSize = 350
SET     @Stretch = 1.8; 

WITH 
 [BaseData] AS
    (SELECT DISTINCT [tab1].[name]	AS 'table'
					,[tab2].[name]	AS 'referenced_table'
					,'X'			AS 'Relationship'
					,[tab1].[name] 
						+ tab2.name AS 'Seq'
    FROM  [sys].[foreign_key_columns] [fkc] 
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
		AND [tab1].[name] = @FactTable)
,[TotCount] AS
    (SELECT COUNT(*) AS 'RecCount'
		FROM [BaseData])
,[RecCount] AS
    (SELECT RANK() OVER (ORDER BY CAST([Seq] AS VARCHAR(255))) AS 'RecID'
			,[RecCount]
			,[BaseData].*
	FROM [BaseData] 
	CROSS JOIN [TotCount])
,[Angles] AS
    (SELECT *
			,SIN(RADIANS((CAST([RecID] AS FLOAT) / CAST([RecCount] AS FLOAT)) * 360)) * 1000 AS 'x'
			,COS(RADIANS((CAST([RecID] AS FLOAT) / CAST([RecCount] AS FLOAT)) * 360)) * 1000 AS 'y'
      FROM RecCount)

SELECT *
		,geometry::STGeomFromText('POINT(' + CAST(y AS VARCHAR(20)) + ' ' + CAST(x AS VARCHAR(20)) + ')', 4326) AS 'Posn'
		,geometry::STPolyFromText('POLYGON ((' + CAST((y * @Stretch) 
								+ @BoxSize AS VARCHAR(20)) + ' ' + CAST(x + (@BoxSize / 2) AS VARCHAR(20)) 
								+ ', ' + CAST((y * @Stretch) - @BoxSize AS VARCHAR(20)) + ' ' + CAST(x + (@BoxSize / 2) AS VARCHAR(20)) 
								+ ', ' + CAST((y * @Stretch) - @BoxSize AS VARCHAR(20)) + ' ' + CAST(x - (@BoxSize / 2) AS VARCHAR(20)) 
								+ ', ' + CAST((y * @Stretch) + @BoxSize AS VARCHAR(20)) + ' ' + CAST(x - (@BoxSize / 2) AS VARCHAR(20)) 
								+ ', ' + CAST((y * @Stretch) + @BoxSize AS VARCHAR(20)) + ' ' + CAST(x + (@BoxSize / 2) AS VARCHAR(20)) 
								+ '))', 0) AS 'Box'
		,geometry::STLineFromText('LINESTRING (0 0, ' + CAST((y * @Stretch) AS VARCHAR(20)) + ' ' + CAST(x AS VARCHAR(20)) + ')', 0) AS 'Line'
		,geometry::STPolyFromText('POLYGON ((' + CAST(0 + @BoxSize * 1.9 AS VARCHAR(20)) + ' ' + CAST(0 + (@BoxSize * 1.5) AS VARCHAR(20)) 
								+ ', ' + CAST(0 - @BoxSize * 1.9 AS VARCHAR(20)) + ' ' + CAST(0 + (@BoxSize * 1.5) AS VARCHAR(20)) 
								+ ', ' + CAST(0 - @BoxSize * 1.9 AS VARCHAR(20)) + ' ' + CAST(0 - (@BoxSize * 1.5) AS VARCHAR(20)) 
								+ ', ' + CAST(0 + @BoxSize * 1.9 AS VARCHAR(20)) + ' ' + CAST(0 - (@BoxSize * 1.5) AS VARCHAR(20)) 
								+ ', ' + CAST(0 + @BoxSize * 1.9 AS VARCHAR(20)) + ' ' + CAST(0 + (@BoxSize * 1.5) AS VARCHAR(20)) 
								+ '))', 0) AS 'CenterBox'
FROM [Angles]
