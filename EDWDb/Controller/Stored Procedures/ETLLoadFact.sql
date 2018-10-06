
CREATE PROCEDURE [Controller].[ETLLoadFact](
	@ModelName nvarchar(124)
)
AS
BEGIN
	IF(@ModelName IS NULL)
		BEGIN
			RAISERROR(50001,16,1,N'@ModelName');
			RETURN;
		END

	DECLARE @FactTableName sysname = N'Fact' + @ModelName;

	DECLARE @TableType nvarchar(64);
	SELECT
		@TableType = CAST([value] AS nvarchar(64))
	FROM fn_listextendedproperty (N'TableType',N'Schema','Model',N'Table',@FactTableName,NULL,NULL);

	IF (@TableType = N'TF')
		EXEC [Controller].[ETLLoadFactTransaction] @FactTableName;
	ELSE IF (@TableType = N'FF')
		EXEC [Controller].[ETLLoadFactTransaction] @FactTableName;
	ELSE IF (@TableType = N'AS')
		EXEC [Controller].[ETLLoadFactAccumulatingSnapshot] @FactTableName;
	ELSE
		BEGIN
			IF (@TableType IS NULL)
				SET @TableType = N'NULL';
			RAISERROR('Invalid fact table type: %s',16,1,@TableType);
		END

	RETURN(0);
END
