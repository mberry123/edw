CREATE FUNCTION [Transform].[fnDimEmployeeVersions] ()
RETURNS TABLE
AS
RETURN
(	SELECT
		 [EmployeeKey]
		,[EmployeeCode]
		,[StartDate]
		,[EndDate]
		,ROW_NUMBER() OVER(
			PARTITION BY [EmployeeCode]
			ORDER BY [StartDate]
		) AS 'Version'
	FROM [Model].[DimEmployee] WITH (NOLOCK)
);
