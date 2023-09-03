IF NOT EXISTS (SELECT * FROM sys.objects O JOIN sys.schemas S ON O.schema_id = S.schema_id WHERE O.NAME = 'stagebasetaxi' AND O.TYPE = 'U' AND S.NAME = 'dbo')
CREATE TABLE dbo.stagebasetaxi
	(
	 [hvfhs_license_num] nvarchar(4000),
	 [dispatching_base_num] nvarchar(4000),
	 [pickup_datetime] datetime2(0),
	 [dropoff_datetime] datetime2(0),
	 [PULocationID] bigint,
	 [DOLocationID] bigint,
	 [SR_Flag] bigint
	)
WITH
	(
	DISTRIBUTION = ROUND_ROBIN,
	 CLUSTERED COLUMNSTORE INDEX
	 -- HEAP
	)
GO

--Uncomment the 4 lines below to create a stored procedure for data pipeline orchestration​
--CREATE PROC bulk_load_stagebasetaxi
--AS
--BEGIN
COPY INTO dbo.stagebasetaxi
(hvfhs_license_num 1, dispatching_base_num 2, pickup_datetime 3, dropoff_datetime 4, PULocationID 5, DOLocationID 6, SR_Flag 7)
FROM 'https://taxidatastorageadls.dfs.core.windows.net/taxidata/fhvtaxis_201911.csv'
WITH
(
	FILE_TYPE = 'CSV'
	,MAXERRORS = 5
	,FIRSTROW = 2
	,ERRORFILE = 'https://taxidatastorageadls.dfs.core.windows.net/taxidata/'
)
--END
GO

SELECT *  FROM dbo.stagebasetaxi
GO