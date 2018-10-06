CREATE VIEW [Transform].[DimDescriptionChangesView]
AS
WITH SysDescriptions
AS (
	SELECT RTRIM(LTRIM(CONVERT(varchar(64),[CurrencyCode]))) COLLATE Latin1_General_CI_AS AS 'DescriptionCode' 
		,CAST('Currency' AS VARCHAR(64)) AS 'DescriptionTypeCode'
		,RTRIM(LTRIM([Name])) COLLATE Latin1_General_CI_AS AS 'Description'
	FROM [$(EDWStagingSnapshotDb)].[Sales].[Currency]
	)

SELECT CONVERT(VARCHAR(64),[SysDescriptions].[DescriptionCode]) AS 'DescriptionCode'
	,CONVERT(VARCHAR(64),[SysDescriptions].[DescriptionTypeCode]) AS 'DescriptionTypeCode'
	,CONVERT(VARCHAR(256),[SysDescriptions].[Description]) AS 'Description'
FROM [SysDescriptions]
INNER JOIN [Transform].[DimDescriptionChangedKeys] ChangeKeys 
	ON (ChangeKeys.[DescriptionCode] = SysDescriptions.[DescriptionCode])



