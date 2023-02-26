IF OBJECT_ID('dbo.dim_riders') IS NOT NULL
BEGIN
  DROP TABLE dbo.dim_riders;
END

CREATE TABLE dim_riders (
	[rider_id] BIGINT,
	[first_name] NVARCHAR(50),
	[last_name] NVARCHAR(50),
	[address] NVARCHAR(255),
	[birthday] DATETIME2,
	[account_start_date] DATETIME2,
	[account_end_date] DATETIME2,
	[is_member] BIT,
	[rider_age_account_start] TINYINT
);

INSERT INTO dim_riders (
	[rider_id],
	[first_name],
	[last_name],
	[address],
	[birthday],
	[account_start_date],
	[account_end_date],
	[is_member],
	[rider_age_account_start])
SELECT
    [rider_id],
	[first],
	[last],
	[address],
	CAST([birthday] AS DATETIME2),
	CAST([account_start_date] AS DATETIME2),
	CAST([account_end_date] AS DATETIME2),
	[is_member],
	DATEDIFF(YEAR, birthday,
        CONVERT(DATETIME, SUBSTRING([account_start_date], 1, 19),120)) - (
            CASE WHEN MONTH(birthday) > MONTH(CONVERT(DATETIME, SUBSTRING([account_start_date], 1, 19),120))
            OR MONTH(birthday) = MONTH(CONVERT(DATETIME, SUBSTRING([account_start_date], 1, 19),120))
            AND DAY(birthday) > DAY(CONVERT(DATETIME, SUBSTRING([account_start_date], 1, 19),120))
            THEN 1 ELSE 0 END
    )
FROM [dbo].[staging_riders];

SELECT TOP (100) * FROM [dbo].[dim_riders];