
CREATE VIEW [Model].[DimCurrencyView]
WITH SCHEMABINDING
AS
SELECT [DescriptionKey] AS 'Currency Key'
      ,[DescriptionCode] AS 'Currency Alternate Key'
      ,[Description] AS 'Currency Name'
  FROM [Model].[DimDescription]
  WHERE [DescriptionTypeCode] = 'Currency';

GO
CREATE UNIQUE CLUSTERED INDEX [NCNU_DimCurrency]
    ON [Model].[DimCurrencyView]([Currency Key] ASC);

