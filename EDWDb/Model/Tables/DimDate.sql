CREATE TABLE [Model].[DimDate] (
    [DateKey]           INT          NOT NULL,
    [EndDate]           DATETIME     NULL,
    [FullDate]          DATE         NULL,
    [DateName]          CHAR (11)    NULL,
    [DateNameUS]        CHAR (11)    NULL,
    [DateNameEU]        CHAR (11)    NULL,
    [DayOfWeek]         TINYINT      NULL,
    [DayNameOfWeek]     CHAR (10)    NULL,
    [DayOfMonth]        TINYINT      NULL,
    [WorkingDayOfMonth] TINYINT      NULL,
    [IsUKBankHoliday]   BIT          NULL,
    [UKBankHoliday]     VARCHAR (30) NULL,
    [DayOfYear]         SMALLINT     NULL,
    [WeekdayWeekend]    CHAR (7)     NULL,
    [WeekOfYear]        TINYINT      NULL,
    [MonthName]         CHAR (10)    NULL,
    [MonthOfYear]       TINYINT      NULL,
    [IsLastDayOfMonth]  BIT          NULL,
    [CalendarQuarter]   TINYINT      NULL,
    [CalendarYear]      SMALLINT     NULL,
    [CalendarYearMonth] CHAR (7)     NULL,
    [CalendarYearQtr]   CHAR (7)     NULL,
    [FiscalMonthOfYear] TINYINT      NULL,
    [FiscalQuarter]     TINYINT      NULL,
    [FiscalYear]        INT          NULL,
    [FiscalYearMonth]   CHAR (9)     NULL,
    [FiscalYearQtr]     CHAR (8)     NULL,
    [StartDate]         DATETIME     NULL,
    [FourCQuarter]      TINYINT      NULL,
    [FourCYear]         SMALLINT     NULL,
    [FourCYearQtr]      CHAR (7)     NULL,
    CONSTRAINT [PK_DimDate_DateKey] PRIMARY KEY CLUSTERED ([DateKey] ASC),
    CONSTRAINT [AK_DimDate_FullDate] UNIQUE NONCLUSTERED ([FullDate] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'TableLoadOrder', @value = N'0', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimDate';


GO
EXECUTE sp_addextendedproperty @name = N'TableType', @value = N'FD', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimDate';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimDate', @level2type = N'COLUMN', @level2name = N'DateKey';


GO
EXECUTE sp_addextendedproperty @name = N'IsMetaData', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimDate', @level2type = N'COLUMN', @level2name = N'EndDate';


GO
EXECUTE sp_addextendedproperty @name = N'KeyType', @value = N'BK,NK', @level0type = N'SCHEMA', @level0name = N'Model', @level1type = N'TABLE', @level1name = N'DimDate', @level2type = N'COLUMN', @level2name = N'FullDate';

