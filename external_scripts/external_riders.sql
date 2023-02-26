IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'udacityproject2_udacityproject2_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [udacityproject2_udacityproject2_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://udacityproject2@udacityproject2.dfs.core.windows.net', 
		TYPE = HADOOP 
	)
GO

CREATE EXTERNAL TABLE dbo.staging_riders (
	[rider_id] BIGINT,
	[first] NVARCHAR(50),
	[last] NVARCHAR(50),
	[address] NVARCHAR(50),
	[birthday] VARCHAR(50),
	[account_start_date] VARCHAR(50),
	[account_end_date] VARCHAR(50),
	[is_member] BIT
	)
	WITH (
	LOCATION = 'publicriderimport.csv',
	DATA_SOURCE = [udacityproject2_udacityproject2_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.staging_riders
GO