
CREATE PROCEDURE [Controller].[ETLInsertFactChanges](
	@ModelName nvarchar(32),
	@ExecutionID bigint
)
AS
BEGIN
	IF(@ModelName IS NULL)
		BEGIN
			RAISERROR(50001,16,1,N'@ModelName');
			RETURN;
		END

	IF(@ExecutionID IS NULL)
		BEGIN
			RAISERROR(50001,16,1,N'@ExecutionID');
			RETURN;
		END

	DECLARE @FactTableName sysname = N'Fact' + @ModelName;

	DECLARE @TableType nvarchar(64);
	SELECT
		@TableType = CAST([value] AS nvarchar(64))
	FROM fn_listextendedproperty (N'TableType',N'Schema','Model',N'Table',@FactTableName,NULL,NULL);

	IF(@TableType = 'TF')
		EXEC [Controller].[ETLTransformFactTransactionChanges] @FactTableName, @ExecutionID;
	ELSE IF(@TableType = 'FF')
		EXEC [Controller].[ETLTransformFactFactlessChanges] @FactTableName, @ExecutionID;
	ELSE IF (@TableType = 'AS')
		EXEC [Controller].[ETLTransformFactAccumulatingSnapshotChanges] @FactTableName, @ExecutionID;
	ELSE
		BEGIN
			IF (@TableType IS NULL)
				SET @TableType = N'NULL';
			RAISERROR('Invalid fact table type: %s',16,1,@TableType);
		END

	RETURN(0);
END
