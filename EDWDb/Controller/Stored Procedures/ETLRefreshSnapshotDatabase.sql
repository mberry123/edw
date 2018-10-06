
CREATE PROCEDURE [Controller].[ETLRefreshSnapshotDatabase](
	@SourceDbName sysname,
	@SnapshotDbName sysname,
	@DebugOnly bit = 0
)
AS
BEGIN
	-- delete the existing snapshot
	DECLARE @DropStatement nvarchar(1024) = N'
	IF EXISTS(
		SELECT * FROM sys.databases
		WHERE ([Name] = ''' + @SnapshotDbName + ''')
	)
		DROP DATABASE [' + @SnapshotDbName + '];
	';
	IF(@DebugOnly = 0)
		EXEC(@DropStatement);
	ELSE
		PRINT @DropStatement;

	-- instantiate the new snapshot
	DECLARE @LogicalName sysname,
		@LogicalNameQuery nvarchar(512) = N'
			SELECT @LogicalName = [name]
			FROM [' + @SourceDbName + '].sys.database_files
			WHERE ([type] = 0);
		';
	EXEC sp_executesql @LogicalNameQuery,
		N'@LogicalName sysname OUTPUT',
		@LogicalName OUTPUT;

	DECLARE @SnapshotDirectory nvarchar(128) = (
		SELECT [Controller].[fnGetConfigurationItem]('Database.Snapshot.Directory')
	);

	DECLARE @CreateStatement nvarchar(1024) = N'
	CREATE DATABASE [' + @SnapshotDbName + '] ON (
		NAME = ''' + @LogicalName + ''', FILENAME = ''' + @SnapshotDirectory + '\' + @SnapshotDbName + '.snap''
	) AS SNAPSHOT OF [' + @SourceDbName + '];
	';
	IF(@DebugOnly = 0)
		EXEC(@CreateStatement);
	ELSE
		PRINT @CreateStatement;

	RETURN(0);
END
