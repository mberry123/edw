CREATE VIEW [Model].[DimDescriptionView]
AS
SELECT [ExecutionID] AS 'Execution Id'
	,[DescriptionKey] AS 'Description Key'
	,[DescriptionCode] AS 'Description Code'
	,[DescriptionTypeCode] AS 'Description Type'
	,[Description] AS 'Description'
FROM [Model].[DimDescription] WITH (NOLOCK);

