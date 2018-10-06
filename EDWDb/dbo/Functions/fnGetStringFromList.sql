CREATE FUNCTION [dbo].[fnGetStringFromList]
(@listString NVARCHAR (4000) NULL, @separator NVARCHAR (4000) NULL, @position INT NULL)
RETURNS NVARCHAR (4000)
AS
 EXTERNAL NAME [EDWDb].[UserDefinedFunctions].[fnGetStringFromList]

