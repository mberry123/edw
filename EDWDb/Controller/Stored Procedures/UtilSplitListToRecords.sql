
CREATE PROCEDURE [Controller].[UtilSplitListToRecords](
	@ListString nvarchar(max),
	@Splitter nvarchar(16)
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @RecordSet TABLE ([Value] nvarchar(256));

	DECLARE @Value nvarchar(256), @ValueStart int = 0, @ValueEnd int = 0;
	WHILE(1=1)
		BEGIN
			IF (@ValueEnd > 0) SET @ValueStart = @ValueEnd;
			SET @ValueEnd = CHARINDEX(@Splitter, @ListString, @ValueStart + 1);
			IF (@ValueEnd = 0) SET @ValueEnd = LEN(@ListString);

			PRINT '@ValueStart: ' + ISNULL(CAST(@ValueStart AS nvarchar),'NULL');
			PRINT '@ValueEnd: ' + ISNULL(CAST(@ValueEnd AS nvarchar),'NULL');
			
			SET @Value = REPLACE(
					SUBSTRING(@ListString, @ValueStart, (@ValueEnd + 1) - @ValueStart)
				, @Splitter, '');
			INSERT INTO @RecordSet VALUES(@Value);
			
			-- check if there are any left
			IF(CHARINDEX(@Splitter, @ListString, @ValueStart + 1) = 0)
				BREAK;
		END

	SELECT [Value] FROM @RecordSet;

	RETURN(0);
END
