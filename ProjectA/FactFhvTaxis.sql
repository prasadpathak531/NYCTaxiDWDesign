ALTER DATABASE SCOPED CONFIGURATION SET DW_COMPATIBILITY_LEVEL = 50;

--- Creating a FACT table for FhvTaxis
CREATE table dbo.FactFhvTaxis
( LicenseNumber BIGINT,
  PULocationID BIGINT,
  DOLocationID BIGINT,
  pickup_datetime DATETIME,
  dropoff_datetime DATETIME,
  SR_Flag BIGINT)
WITH
(
    DISTRIBUTION = HASH(LicenseNumber, PULocationID, DOLocationID),
    CLUSTERED COLUMNSTORE INDEX
);

INSERT INTO dbo.FactFhvTaxis
SELECT  
      (SELECT MAX(b.LicenseNumber)
      FROM dbo.DimBases b
      WHERE trim(lower(b.LicenseNumber)) = trim(lower(ft.dispatching_base_num))) as LicenseNumber,
      (SELECT MAX(tz.LocationID)
      FROM dbo.DimTaxiZones tz
      WHERE tz.LocationID = ft.PULocationID) as PULocationID,
      (SELECT MAX(tz.LocationID)
      FROM dbo.DimTaxiZones tz
      WHERE tz.LocationID = ft.DOLocationID) as DOLocationID,
      ft.pickup_datetime,
      ft.dropoff_datetime,
      COALESCE(ft.SR_Flag,0) as SR_Flag
FROM dbo.FhvTaxis as ft;

SELECT TOP 100
* FROM dbo.FactFhvTaxis;


