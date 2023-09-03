IF NOT EXISTS (SELECT * FROM sys.objects O JOIN sys.schemas S ON O.schema_id = S.schema_id WHERE O.NAME = 'stagedimbase' AND O.TYPE = 'U' AND S.NAME = 'dbo')
CREATE TABLE dbo.stagedimbase
	(
	 [BaseLicenseId] nvarchar(4000),
	 [BaseType] nvarchar(4000),
	 [AddressBuilding] nvarchar(4000),
	 [AddressStreet] nvarchar(4000),
	 [AddressCity] nvarchar(4000),
	 [AddressState] nvarchar(4000),
	 [AddressPostalCode] bigint
	)
WITH
	(
	DISTRIBUTION = ROUND_ROBIN,
	 CLUSTERED COLUMNSTORE INDEX
	 -- HEAP
	)
GO

--Uncomment the 4 lines below to create a stored procedure for data pipeline orchestration​
--CREATE PROC bulk_load_stagedimbase
--AS
--BEGIN
COPY INTO dbo.stagedimbase
(BaseLicenseId 1, BaseType 2, AddressBuilding 3, AddressStreet 4, AddressCity 5, AddressState 6, AddressPostalCode 7)
FROM 'https://taxidatastorageadls.dfs.core.windows.net/taxidata/Dimensions/FhvBases.parquet/part-00000-d04cc995-11fa-4b40-9d77-43b1e5b89f94-c000.snappy.parquet'
WITH
(
	FILE_TYPE = 'PARQUET'
	,MAXERRORS = 5
)
--END
GO


GO