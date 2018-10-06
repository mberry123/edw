CREATE FUNCTION [dbo].[fnRegexFind]
(@expressionToFind NVARCHAR (MAX) NULL, @expressionToSearch NVARCHAR (MAX) NULL, @instanceToReturn INT NULL)
RETURNS NVARCHAR (MAX)
AS
 EXTERNAL NAME [EDWDb].[UserDefinedFunctions].[fnRegexFind]

