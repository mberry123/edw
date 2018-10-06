CREATE FUNCTION [Report].[fnUnstringParameterList]
   (@RepParam nvarchar(max), @Delim char(1)= ',')
RETURNS @Values TABLE (ListItems nvarchar(100))AS

--Relies on comma separated string being passed
--DECLARE @ClientID VARCHAR(MAX) OR sproc parameter defined as so
--CROSS APPLY [Report].[fnUnstringParameterList](@ClientID,',') ClientList
--CROSS APPLY [Report].[fnUnstringParameterList](@DocumentCode,',') DocumentCodes

  BEGIN
  DECLARE @chrind INT
  DECLARE @Piece nvarchar(100)
  SELECT @chrind = 1 
  WHILE @chrind > 0
    BEGIN
      SELECT @chrind = CHARINDEX(@Delim,@RepParam)
      IF @chrind  > 0
        SELECT @Piece = LEFT(@RepParam,@chrind - 1)
      ELSE
        SELECT @Piece = @RepParam
      INSERT  @Values(ListItems) VALUES(@Piece)
      SELECT @RepParam = RIGHT(@RepParam,LEN(@RepParam) - @chrind)
      IF LEN(@RepParam) = 0 BREAK
    END
  RETURN
  END
