CREATE FUNCTION [Transform].[fnRegexFind]
(@expressionToFind NVARCHAR (MAX) NULL, @expressionToSearch NVARCHAR (MAX) NULL, @instanceToReturn INT NULL)
RETURNS NVARCHAR (4000)
AS
 EXTERNAL NAME [EDWDb].[UserDefinedFunctions].[fnRegexFind]

