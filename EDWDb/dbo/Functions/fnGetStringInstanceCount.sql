CREATE FUNCTION [dbo].[fnGetStringInstanceCount]
(@findString NVARCHAR (4000) NULL, @searchString NVARCHAR (4000) NULL)
RETURNS INT
AS
 EXTERNAL NAME [EDWDb].[UserDefinedFunctions].[fnGetStringInstanceCount]

