
CREATE PROCEDURE [Controller].[SaveExecutionState](
	@PropertyID VARCHAR(64),
	@PropertyValue VARCHAR(256)
)
AS
BEGIN
	IF (@PropertyValue IS NULL)
		BEGIN
			RAISERROR(50001,16,1,N'@PropertyValue');
			RETURN;
		END

	UPDATE [Controller].[ExecutionState]
	SET
		[PropertyValue] = @PropertyValue
	WHERE ([PropertyID] = @PropertyID);
	
	IF(@@ROWCOUNT = 0)
		BEGIN
			RAISERROR(50004,16,1,@PropertyID,N'');
			RETURN;
		END

	RETURN(0);
END

