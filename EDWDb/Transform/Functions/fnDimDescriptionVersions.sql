CREATE FUNCTION [Transform].[fnDimDescriptionVersions] ()
RETURNS TABLE
AS
RETURN
(	SELECT
		 [DescriptionKey]
		,[DescriptionCode]
		,[DescriptionTypeCode]
		,[StartDate]
		,[EndDate]
		,1 AS 'Version'
	FROM [Model].[DimDescription] WITH (NOLOCK)
);
