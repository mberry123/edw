CREATE TYPE [Controller].[PackageParametersType] AS TABLE (
    [ParameterName]  NVARCHAR (128) NULL,
    [ParameterValue] SQL_VARIANT    NULL,
    [ParameterType]  SMALLINT       NULL,
    [DataType]       NVARCHAR (32)  NULL);

