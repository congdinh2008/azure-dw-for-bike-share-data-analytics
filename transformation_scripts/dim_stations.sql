IF OBJECT_ID('dbo.dim_stations') IS NOT NULL
BEGIN
  DROP TABLE dbo.dim_stations;
END

CREATE TABLE dim_stations (
	[station_id] VARCHAR(50),
	[name] NVARCHAR(100),
	[latitude] FLOAT,
	[longitude] FLOAT
);

INSERT INTO dim_stations (
	[station_id],
	[name],
	[latitude],
	[longitude])
SELECT
    [station_id],
    [name],
	[latitude],
    [longitude]
FROM [dbo].[staging_stations];

SELECT TOP (100) * FROM [dbo].[dim_stations];