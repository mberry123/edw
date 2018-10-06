
CREATE PROCEDURE [Controller].[ETLReplaceTokenForColumnUpdatePredicates](
	@DMLStatement nvarchar(max) OUTPUT,
	@Token nvarchar(128),
	@TargetColumnName sysname,
	@SourceTableAlias sysname,
	@SourceColumnName sysname,
	@ReinsertToken bit = 0,
	@AppendToList bit = 0,
	@IsDimensionKey bit = 0,
	@TargetTableName sysname
)
AS

BEGIN

	DECLARE @IsExecutionID BIT = 0;
	DECLARE @IsNullable BIT = 0;
	DECLARE @NullableReplacementValue VARCHAR(64);
	SELECT @IsExecutionID = CASE WHEN @SourceColumnName = 'ExecutionID' THEN 1 ELSE 0 END

		SELECT @IsNullable = CASE 
				WHEN [SystemTable].[IS_NULLABLE] = 'YES'
					THEN 1
				ELSE 0
				END
		FROM INFORMATION_SCHEMA.COLUMNS SystemTable
		CROSS APPLY (
			SELECT [TableType]
			FROM [Controller].[fnModelTables]([SystemTable].[TABLE_NAME])
			) CurrentTable
		WHERE [SystemTable].[IS_NULLABLE] = 'YES'
			AND [CurrentTable].[TableType] = 'AS'
			AND [SystemTable].[TABLE_SCHEMA] = 'Model'
			AND [SystemTable].[TABLE_NAME] = REPLACE(REPLACE(@TargetTableName, '[Model].[', ''), ']', '')
			AND [SystemTable].[COLUMN_NAME] = @TargetColumnName;

		SELECT @NullableReplacementValue = CASE 
				WHEN [SystemTable].[DATA_TYPE] IN (
						'bit'
						,'int'
						,'decimal'
						,'numeric'
						)
					THEN '0'
				ELSE CASE 
						WHEN [SystemTable].[DATA_TYPE] IN (
								'date'
								,'datetime'
								)
							THEN '''01 JAN 1900'''
						ELSE CASE 
								WHEN [SystemTable].[DATA_TYPE] IN ('time')
									THEN '''00:00:00'''
								ELSE ''''''
								END
						END
				END
		FROM INFORMATION_SCHEMA.COLUMNS SystemTable
		CROSS APPLY (
			SELECT [TableType]
			FROM [Controller].[fnModelTables]([SystemTable].[TABLE_NAME])
			) CurrentTable
		WHERE [SystemTable].[IS_NULLABLE] = 'YES'
			AND [CurrentTable].[TableType] = 'AS'
			AND [SystemTable].[TABLE_SCHEMA] = 'Model'
			AND [SystemTable].[TABLE_NAME] = REPLACE(REPLACE(@TargetTableName, '[Model].[', ''), ']', '')
			AND [SystemTable].[COLUMN_NAME] = @TargetColumnName;

	SET @DMLStatement = REPLACE(@DMLStatement,
		@Token,
		(CASE
			WHEN (@ReinsertToken = 0) THEN N''
			ELSE @Token + CHAR(10) + REPLICATE(CHAR(9),1)
		END) + 
		(CASE
			WHEN @AppendToList = 1 THEN N' OR '
			ELSE N''
		END) +
		CASE WHEN (@IsNullable = 1) THEN N'ISNULL(target.[' + @TargetColumnName + N'],' + + @NullableReplacementValue + ')  <> ' ELSE N'target.[' + @TargetColumnName + N'] <> ' END + 
		(CASE
			WHEN (@IsDimensionKey = 1) THEN N'ISNULL(' + @SourceTableAlias + N'.[' + @SourceColumnName + N']' + N',-1)'
			WHEN (@IsNullable = 1) THEN N'ISNULL(' + @SourceTableAlias + N'.[' + @SourceColumnName + N']' + N',' + @NullableReplacementValue + ')'
			WHEN (@IsExecutionID = 1) THEN N'target' + N'.[' + @SourceColumnName + N']' --Column self join for ExecutionID column is deliberate so that it will always return false result
			ELSE @SourceTableAlias + N'.[' + @SourceColumnName + N']'
		END)
	);
	RETURN(0);
END
