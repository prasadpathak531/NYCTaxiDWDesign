IF NOT EXISTS (SELECT * FROM sys.objects O JOIN sys.schemas S ON O.schema_id = S.schema_id WHERE O.NAME = 'stagezone' AND O.TYPE = 'U' AND S.NAME = 'dbo')
create TABLE dbo.stagezone
	(
	 [LocationID] bigint,
	 [Borough] nvarchar(4000),
	 [Zone] nvarchar(4000),
	 [service_zone] nvarchar(4000)
	)
WITH
	(
	DISTRIBUTION = ROUND_ROBIN,
	 CLUSTERED COLUMNSTORE INDEX
	 -- HEAP
	)
GO

--Uncomment the 4 lines below to create a stored procedure for data pipeline orchestration​
--CREATE PROC bulk_load_stagezone
--AS
--BEGIN
COPY INTO dbo.stagezone
(LocationID 1, Borough 2, Zone 3, service_zone 4)
FROM 'https://taxidatastorageadls.dfs.core.windows.net/taxidata/taxizones'
WITH
(
	FILE_TYPE = 'CSV'
	,MAXERRORS = 5
	,FIRSTROW = 1
	,ERRORFILE = 'https://taxidatastorageadls.dfs.core.windows.net/taxidata/'
)
--END
GO

SELECT  * FROM dbo.stagezone order by [LocationID] asc
GO