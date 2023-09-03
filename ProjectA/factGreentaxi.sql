
-- Fact table for GreenTaxis
CREATE table dbo.FactGreenTaxis
(VendorID INT,
 lpep_pickup_datetime DATETIME2,
 lpep_dropoff_datetime DATETIME2,
 passengerCount INT,
 TripType INT,
 tripDistance FLOAT,
 RatecodeID INT,
 store_and_fwd_flag VARCHAR(4000),
 PULocationID INT,
 DOLocationID INT,
 PaymentType INT,
 FareAmount FLOAT,
 TotalAmount FLOAT)
WITH
(
    DISTRIBUTION = HASH(VendorID, RatecodeID, PULocationID, DOLocationID),
    CLUSTERED COLUMNSTORE INDEX
);

INSERT INTO dbo.FactGreenTaxis
SELECT  gt.VendorID,
        gt.lpep_pickup_datetime,
        gt.lpep_dropoff_datetime,
        gt.passenger_count as passengerCount,
        gt.trip_distance as tripDistance,
        cast(gt.trip_type as INT) as TripType,
        (SELECT MAX(a.RateCodeId)
         FROM dbo.DimRateCodes a
         WHERE a.RateCodeId = gt.RatecodeID) as RatecodeID,
        gt.store_and_fwd_flag,
        (SELECT MAX(b.LocationID)
        FROM dbo.DimTaxiZones b
        WHERE b.LocationID = gt.PULocationID) as PULocationID,
        (SELECT MAX(c.LocationID)
        FROM dbo.DimTaxiZones c
        WHERE c.LocationID = gt.DOLocationID) as DOLocationID,
        gt.payment_type as PaymentType,
        gt.fare_amount as FareAmount,
        gt.total_amount as TotalAmount
        
FROM dbo.GreenTaxis as gt;

SELECT TOP 100 *
FROM dbo.FactGreenTaxis;
