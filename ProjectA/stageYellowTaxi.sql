IF NOT EXISTS (SELECT * FROM sys.objects O JOIN sys.schemas S ON O.schema_id = S.schema_id WHERE O.NAME = 'stageYellowtaxi' AND O.TYPE = 'U' AND S.NAME = 'dbo')
CREATE TABLE dbo.stageYellowtaxi
	(
	 [VendorID] int,
	 [tpep_pickup_datetime] datetime2(7),
	 [tpep_dropoff_datetime] datetime2(7),
	 [passenger_count] int,
	 [trip_distance] float,
	 [RatecodeID] int,
	 [store_and_fwd_flag] nvarchar(4000),
	 [PULocationID] int,
	 [DOLocationID] int,
	 [payment_type] int,
	 [fare_amount] float,
	 [extra] float,
	 [mta_tax] float,
	 [tip_amount] float,
	 [tolls_amount] float,
	 [improvement_surcharge] float,
	 [total_amount] float,
	 [congestion_surcharge] float
	)
WITH
	(
	DISTRIBUTION = HASH(PULocationID),
	 CLUSTERED COLUMNSTORE INDEX
	 -- HEAP
	)
GO

--Uncomment the 4 lines below to create a stored procedure for data pipeline orchestration​
--CREATE PROC bulk_load_stageYellowtaxi
--AS
--BEGIN
COPY INTO dbo.stageYellowtaxi
(VendorID 1, tpep_pickup_datetime 2, tpep_dropoff_datetime 3, passenger_count 4, trip_distance 5, RatecodeID 6, store_and_fwd_flag 7, PULocationID 8, DOLocationID 9, payment_type 10, fare_amount 11, extra 12, mta_tax 13, tip_amount 14, tolls_amount 15, improvement_surcharge 16, total_amount 17, congestion_surcharge 18)
FROM 'https://taxidatastorageadls.dfs.core.windows.net/taxidata/YellowTaxis_201911.parquet'
WITH
(
	FILE_TYPE = 'PARQUET'
	,MAXERRORS = 5
)
--END
GO

SELECT * FROM dbo.stageYellowtaxi
GO