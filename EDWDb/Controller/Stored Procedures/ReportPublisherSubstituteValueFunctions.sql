
CREATE PROCEDURE [Controller].[ReportPublisherSubstituteValueFunctions](
	@ReportXml varchar(max) OUTPUT
)
AS
BEGIN
	DECLARE @ReportXmlDOM xml = CAST(@ReportXml AS xml);

	DECLARE @LoopCount int = 1, @PoisonedLoopLimit int = 100;
	-- loop through all value function parameter types and substitute the value
	WHILE(@ReportXmlDOM.exist('//Parameter[@ValueFunctionName != "" and @Value = ""]') = 1)
		AND(@LoopCount <= @PoisonedLoopLimit)
		BEGIN
			DECLARE @ParameterXml xml = @ReportXmlDOM.query('(//Parameter[@ValueFunctionName != "" and @Value = ""])[1]');
			DECLARE @ParameterName nvarchar(128) = @ParameterXml.value('(/Parameter/@Name)[1]','nvarchar(128)')
				,@ValueFunctionName nvarchar(128) = @ParameterXml.value('(/Parameter/@ValueFunctionName)[1]','nvarchar(128)');

			IF(@ValueFunctionName NOT LIKE CAST('%(%)' AS nvarchar(128)))
				SET @ValueFunctionName = CAST((@ValueFunctionName + '()') AS nvarchar(128));

			DECLARE @ParameterValue varchar(1000)
				,@FunctionStatement nvarchar(256) = N'SELECT @ParameterValue = ISNULL([Controller].' + @ValueFunctionName + N',''-'')';
			EXEC sp_executesql @FunctionStatement
				,N'@ParameterValue varchar(1000) OUTPUT'
				,@ParameterValue OUTPUT;

			-- add the value
			SET @ReportXmlDOM.modify('replace value of (//Parameter[@ValueFunctionName != "" and @Name = sql:variable("@ParameterName")]/@Value)[1] with sql:variable("@ParameterValue")');

			PRINT @LoopCount;
			SET @LoopCount += 1;
		END

	SET @ReportXml = CAST(@ReportXmlDOM AS varchar(max));

	RETURN(0);
END

