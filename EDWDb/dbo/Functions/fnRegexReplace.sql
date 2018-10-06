CREATE FUNCTION [dbo].[fnRegexReplace]
(@expressionToFind NVARCHAR (MAX) NULL, @expressionToSearch NVARCHAR (MAX) NULL, @stringReplacement NVARCHAR (MAX) NULL)
RETURNS NVARCHAR (MAX)
AS
 EXTERNAL NAME [EDWDb].[UserDefinedFunctions].[fnRegexReplace]

