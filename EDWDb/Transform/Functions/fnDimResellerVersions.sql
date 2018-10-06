CREATE FUNCTION [Transform].[fnDimResellerVersions] ()
RETURNS TABLE
AS
RETURN
(	SELECT
		 [ResellerKey]
		,[ResellerID]
		,[StartDate]
		,[EndDate]
		,ROW_NUMBER() OVER(
			PARTITION BY [ResellerID]
			ORDER BY [StartDate]
		) AS 'Version'
	FROM [Model].[DimReseller] WITH (NOLOCK)
);
