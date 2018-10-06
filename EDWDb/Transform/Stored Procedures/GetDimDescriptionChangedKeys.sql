CREATE PROCEDURE [Transform].[GetDimDescriptionChangedKeys](
	@DebugOnly bit = 0
)
AS
BEGIN
	-- get the version number of the previous transform
	DECLARE @LastTransformedVersion bigint;
	SELECT
		@LastTransformedVersion = NULLIF(CAST([PropertyValue] AS bigint),0)
	FROM [Controller].[ExecutionState]
	WHERE ([PropertyID] = 'DimDescriptionVersion');

	-- list the dependant tables
	DECLARE @DependantStagingTables table ([TableName] sysname);
	INSERT INTO @DependantStagingTables VALUES
		(N'[Sales].[Currency]')
		;

	IF (@DebugOnly = 1)
		BEGIN
			SELECT [TableName] FROM @DependantStagingTables;
			RETURN;
		END

	DECLARE C_DEPENDANT_TABLES CURSOR FAST_FORWARD FOR(
		SELECT [TableName] FROM @DependantStagingTables
	);
	DECLARE @TableName sysname;
	OPEN C_DEPENDANT_TABLES;
	FETCH NEXT FROM C_DEPENDANT_TABLES INTO @TableName;
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		-- get the min version number for the table
		DECLARE @MinValidVersion bigint;
		DECLARE @GetMinSyncVersionStatement nvarchar(512) = N'SET @MinValidVersion = CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID(''' + @TableName + '''))';
		EXEC [$(EDWStagingSnapshotDb)].dbo.sp_executesql @GetMinSyncVersionStatement,
		N'@MinValidVersion bigint OUTPUT',
		@MinValidVersion OUTPUT;

		-- reset the last transformed version if out of scope
		IF (@LastTransformedVersion < @MinValidVersion)
			SET @LastTransformedVersion = NULL;

		FETCH NEXT FROM C_DEPENDANT_TABLES INTO @TableName;
	END
	CLOSE C_DEPENDANT_TABLES;
	DEALLOCATE C_DEPENDANT_TABLES;
				
	-- get the version number to save
	DECLARE @NextTransfomVersion bigint;
	DECLARE @GetNextTransfomVersionStatement nvarchar(512) = N'SET @NextTransfomVersion = CHANGE_TRACKING_CURRENT_VERSION()';
	EXEC [$(EDWStagingSnapshotDb)].dbo.sp_executesql @GetNextTransfomVersionStatement,
	N'@NextTransfomVersion bigint OUTPUT',
	@NextTransfomVersion OUTPUT;

	IF (@LastTransformedVersion IS NOT NULL)
		BEGIN
			-- check that the load procedure has cleared the changes
			IF EXISTS(
				SELECT * FROM [Transform].[DimDescriptionChangedKeys]
			)
				RETURN(0);

			DECLARE @GetChangesStatement nvarchar(max) = N'
			WITH ChangedKeys AS (
			
				SELECT RTRIM(LTRIM(CONVERT(varchar(64),[Changes].[CurrencyCode]))) COLLATE Latin1_General_CI_AS AS [Code]
				FROM CHANGETABLE(CHANGES [Sales].[Currency], @LastTransformedVersion) AS Changes

			)
			
			SELECT DISTINCT [code] FROM ChangedKeys WHERE [code] IS NOT NULL';

			INSERT INTO [Transform].[DimDescriptionChangedKeys]([DescriptionCode])
			EXEC [$(EDWStagingSnapshotDb)].dbo.sp_executesql
				@GetChangesStatement,
				N'@LastTransformedVersion bigint',
				@LastTransformedVersion;
		END
	ELSE
		BEGIN
			TRUNCATE TABLE [Transform].[DimDescriptionChangedKeys];

			-- for first time sync, get all keys
			INSERT INTO [Transform].[DimDescriptionChangedKeys]([DescriptionCode])
			SELECT RTRIM(LTRIM(CONVERT(varchar(64),[Changes].[CurrencyCode]))) COLLATE Latin1_General_CI_AS AS [Code]
			FROM [$(EDWStagingSnapshotDb)].[Sales].[Currency] Changes;
		END

	-- save the version number for the next transform
	UPDATE [Controller].[ExecutionState]
	SET [PropertyValue] = CAST(@NextTransfomVersion AS varchar(256))
	WHERE ([PropertyID] = 'DimDescriptionVersion');

	RETURN(0);
END
