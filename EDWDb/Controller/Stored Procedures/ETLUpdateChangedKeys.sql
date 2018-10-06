
CREATE PROCEDURE [Controller].[ETLUpdateChangedKeys]
AS
BEGIN
	-- Call the GetChangedKeys proc for each fact and dimension table
	-- This proc is called before the Staging snapshot database is refreshed
	-- to ensure that all the keys that have changed are in the snapshot database

	DECLARE C_MODEL_TABLES CURSOR FAST_FORWARD FOR(
		SELECT OBJECT_NAME([major_id]) AS 'TableName'
		FROM sys.extended_properties
		WHERE ([name] = 'TableType')
    -- We don't want daily keys everytime. It has a negative impact on the Common Values procs. 
	-- This is only populated at day end.
	-- Also we want to get FactCaseClientCustomer changes after the controller has run DimCase, DimClient, DimCustomer
	-- And FactCaseRevisions so we will call that in the Dimension Controller afterwards.
		AND  OBJECT_NAME([major_id]) 
		   NOT IN ('DimCaseDaily',
		           'FactCaseClientCustomer',
				   'FactCaseClientCustomerCurrent')
	) ORDER BY [TableName] DESC;
	DECLARE @TableName sysname;
	OPEN C_MODEL_TABLES;
	FETCH NEXT FROM C_MODEL_TABLES INTO @TableName;
	WHILE(@@FETCH_STATUS = 0)
		BEGIN
			DECLARE @FQChangedKeysProcName sysname = LEFT(N'[Transform].[Get' + @TableName + 'ChangedKeys]',128);
			DECLARE @AuditChangedKeysProcName sysname = LEFT(N'[Audit].[Count' + @TableName + 'ChangedKeys]',128);

			IF OBJECT_ID(@FQChangedKeysProcName) IS NOT NULL
				BEGIN
					BEGIN TRY
						EXEC(@FQChangedKeysProcName);
						EXEC(@AuditChangedKeysProcName);
					END TRY
					BEGIN CATCH
						DECLARE @ExceptionMessage nvarchar(2048) = CAST(
								N'Failed to save change keys for ' + @TableName + N' : ' + 
								ERROR_MESSAGE()
							AS nvarchar(2048));
						THROW 50001, @ExceptionMessage, 1;
					END CATCH
				END

			FETCH NEXT FROM C_MODEL_TABLES INTO @TableName;
		END
	CLOSE C_MODEL_TABLES;
	DEALLOCATE C_MODEL_TABLES;

	-- Add any non changed keys tables to audit table
	EXEC [Controller].[ETLLogNonChangedKeyTables];

	RETURN(0);
END
