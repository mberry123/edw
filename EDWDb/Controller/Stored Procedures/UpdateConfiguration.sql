
CREATE PROCEDURE [Controller].[UpdateConfiguration](
	@ConfigXml xml, 
	@RefreshConfig bit = 0
)
AS
BEGIN
	IF(@ConfigXml IS NULL)
		BEGIN
			RAISERROR(50001,16,1,'@ConfigXml');
			RETURN;
		END

	IF(@RefreshConfig = 1)
		TRUNCATE TABLE [Controller].[Configuration];

	DECLARE @docHandle int
	EXEC sp_xml_preparedocument @docHandle OUTPUT, @ConfigXml;

	MERGE [Controller].[Configuration] AS target 
	USING(
		SELECT
			[KeyName],
			[KeyValue],
			[KeyDescription],
			[Overwrite]
		FROM OPENXML(@docHandle,'Config/Item')
		WITH(
			[KeyName] varchar(128) '@name',
			[KeyValue] varchar(4000) '@value',
			[KeyDescription] nvarchar(256) '@description',
			[Overwrite] bit '@overwrite'
		)
	) AS source
		ON (source.[KeyName] = target.[KeyName])
	WHEN MATCHED THEN
		UPDATE SET
			[KeyValue] = (CASE source.[Overwrite] WHEN 1 THEN source.[KeyValue] ELSE target.[KeyValue] END),
			[KeyDescription] = (CASE source.[Overwrite] WHEN 1 THEN source.[KeyDescription] ELSE target.[KeyDescription] END)
	WHEN NOT MATCHED BY TARGET THEN
		INSERT([KeyName],[KeyValue],[KeyDescription])
		VALUES(source.[KeyName],source.[KeyValue],source.[KeyDescription])
	WHEN NOT MATCHED BY SOURCE THEN
		DELETE;
		
	RETURN(0);
END
