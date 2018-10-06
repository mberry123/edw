
CREATE FUNCTION [Support].[GetDateFromInt](
	@Date INT,
	@Time INT
)
RETURNS DATETIME
AS
BEGIN
	DECLARE @ReturnValue datetime

	DECLARE @ConvertedDate datetime
	SET @ConvertedDate = CONVERT(datetime,CAST(@Date AS char(10)),112)

	DECLARE @TimeInSeconds int
	SET @TimeInSeconds = (((@Time % 1000000)/10000)*3600)+ (((@Time % 10000)/100)*60) + (@Time % 100)

	SET @ReturnValue = DATEADD(ss ,@TimeInSeconds, @ConvertedDate)

	RETURN(@ReturnValue)
END
