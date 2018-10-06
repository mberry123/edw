CREATE FUNCTION [Transform].[fnDimCustomerVersions] ()
RETURNS TABLE
AS
RETURN
(	SELECT
		 [CustomerKey]
        ,[CustomerID]
		,[StartDate]
		,[EndDate]
		,[Version]
	FROM [Model].[DimCustomer] WITH (NOLOCK)
);
