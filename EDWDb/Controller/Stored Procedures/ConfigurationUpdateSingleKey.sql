
CREATE PROCEDURE [Controller].[ConfigurationUpdateSingleKey](
	@KeyName varchar(128)
	,@KeyValue varchar(4000)
)
AS
BEGIN
	DECLARE @RC int = 0;

	IF EXISTS(
		SELECT * FROM [Controller].[Configuration]
		WHERE ([KeyName] = @KeyName)
	)
		BEGIN
			UPDATE [Controller].[Configuration]
			SET [KeyValue] = CAST(@KeyValue AS NVARCHAR(256))
			WHERE ([KeyName] = @KeyName);
		END
	ELSE
		BEGIN
			SET @RC = 50001;
			DECLARE @ExceptionMessage nvarchar(2000) = N'The parameter @KeyName (' + @KeyName + ') is not valid.';
			THROW @RC, @ExceptionMessage, 1;
		END

	RETURN(@RC);
END
