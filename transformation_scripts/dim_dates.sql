IF OBJECT_ID('dbo.dim_dates') IS NOT NULL
BEGIN
  DROP TABLE dbo.dim_dates;
END

CREATE TABLE #temp_date
(
  [date] DATE,
  [day] TINYINT,
  [month] TINYINT,
  [name_of_month] VARCHAR(12),
  [week] TINYINT,
  [day_of_week] TINYINT,
  [quarter] TINYINT,
  [year] SMALLINT,
  style112 CHAR(8)
);


SET DATEFIRST 7;
SET DATEFORMAT mdy;
SET LANGUAGE US_ENGLISH;

DECLARE @StartDate DATETIME;
DECLARE @EndDate DATETIME;
DECLARE @NumberOfYear INT = 1;
SET @StartDate = (SELECT MIN(TRY_CONVERT(DATETIME, LEFT(start_at, 19))) FROM dbo.staging_trips)
SET @EndDate = DATEADD(YEAR, @NumberOfYear, (SELECT MAX(TRY_CONVERT(DATETIME, LEFT(start_at, 19))) FROM staging_trips))

-- The code is a SQL Server T-SQL script that inserts a range of dates into a temporary table called #temp_date. 
-- The dates are generated dynamically based on two input parameters, @StartDate and @EndDate.
INSERT INTO #temp_date
  ([date])
SELECT d
FROM
  (
  SELECT d = DATEADD(DAY, rn - 1, @StartDate)
  FROM
    (
    SELECT TOP (DATEDIFF(DAY, @StartDate, @EndDate))
      rn = ROW_NUMBER() OVER (ORDER BY s1.[object_id])
    FROM sys.all_objects AS s1
    CROSS JOIN sys.all_objects AS s2
    ORDER BY s1.[object_id]
  ) AS x
) AS y;


UPDATE #temp_date 
set 
  [day]        		= DATEPART(DAY,      [date]),
  [month]      		= DATEPART(MONTH,    [date]),
  [name_of_month]   = DATENAME(MONTH,    [date]),
  [week]       		= DATEPART(WEEK,     [date]),
  [day_of_week]  	= DATEPART(WEEKDAY,  [date]),
  [quarter]    		= DATEPART(QUARTER,  [date]),
  [year]       		= DATEPART(YEAR,     [date]),
  [style112]     	= CONVERT(CHAR(8),   [date], 112);

-- Create a dimension date table
CREATE TABLE dim_dates
(
  [date_id] INT,
  [date] DATE,
  [day] TINYINT,
  [month] TINYINT,
  [name_of_month] VARCHAR(12),
  [week] TINYINT,
  [day_of_week] TINYINT,
  [quarter] TINYINT,
  [year] SMALLINT
);

INSERT INTO dim_dates
  (
  [date_id],
  [date],
  [day],
  [day_of_week],
  [week],
  [month],
  [name_of_month],
  [quarter],
  [year]
  )
SELECT
  [date_id]         = CONVERT(INT, [style112]),
  [date]        	= [date],
  [day]         	= CONVERT(TINYINT, [day]),
  [day_of_week]     = CONVERT(TINYINT, [day_of_week]),
  [week]	        = CONVERT(TINYINT, [week]),
  [month]       	= CONVERT(TINYINT, [month]),
  [name_of_month]   = CONVERT(VARCHAR(10), [name_of_month]),
  [quarter]     	= CONVERT(TINYINT, [quarter]),
  [year]        	= [year]
FROM #temp_date;

DROP TABLE #temp_date;


SELECT
  *
FROM dim_dates
ORDER BY [date] DESC