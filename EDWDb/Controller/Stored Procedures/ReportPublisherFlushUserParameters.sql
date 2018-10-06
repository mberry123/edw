
CREATE PROCEDURE [Controller].[ReportPublisherFlushUserParameters](
	@ReportUserName varchar(128)
	,@ReportParameterName varchar(128)
)
AS
BEGIN
	DECLARE @RC int = 0;
	
	DELETE [Report].[ReportPublisherUserParameters]
	WHERE  ([ReportUserName] = @ReportUserName)
		AND([ReportParameterName] = @ReportParameterName);

	RETURN(@RC);	
END
