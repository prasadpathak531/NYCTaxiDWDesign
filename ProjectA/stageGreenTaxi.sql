IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseParquetFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseParquetFormat] 
	WITH ( FORMAT_TYPE = PARQUET)
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'taxidata_taxidatastorageadls_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [taxidata_taxidatastorageadls_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://taxidata@taxidatastorageadls.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE dbo.stageGreenTaxi (
	[VendorID] nvarchar(4000),
	[lpep_pickup_datetime] nvarchar(4000),
	[lpep_dropoff_datetime] nvarchar(4000),
	[RatecodeID] nvarchar(4000),
	[PULocationID] nvarchar(4000),
	[DOLocationID] nvarchar(4000),
	[passenger_count] nvarchar(4000),
	[trip_distance] nvarchar(4000),
	[fare_amount] nvarchar(4000),
	[total_amount] nvarchar(4000),
	[payment_type] nvarchar(4000),
	[trip_type] nvarchar(4000),
	[congestion_surcharge] nvarchar(4000)
	)
	WITH (
	LOCATION = 'part-00000-eaee1ba1-2503-41a2-afa8-768faee62866-c000.snappy.parquet',
	DATA_SOURCE = [taxidata_taxidatastorageadls_dfs_core_windows_net],
	FILE_FORMAT = [SynapseParquetFormat]
	)
GO


SELECT TOP 100 * FROM dbo.stageGreenTaxi
GO