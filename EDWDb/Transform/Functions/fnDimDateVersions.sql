CREATE FUNCTION [Transform].[fnDimDateVersions] ()
RETURNS TABLE
AS
RETURN
(	SELECT
		 [DateKey]
		,[FullDate]
		,'1900-01-01' AS [StartDate]
		,[EndDate]
		,1 AS 'Version'
	FROM [Model].[DimDate] WITH (NOLOCK)
);
