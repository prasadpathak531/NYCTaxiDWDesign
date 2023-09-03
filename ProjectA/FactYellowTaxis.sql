-- FACT table for Yellow taxis
CREATE table dbo.FactYellowTaxis
(VendorID BIGINT,
 tpep_pickup_datetime DATETIME,
 tpep_dropoff_datetime DATETIME,
 passengerCount INT,
 tripDistance FLOAT,
 RatecodeID BIGINT,
 store_and_fwd_flag VARCHAR(4000),
 PULocationID BIGINT,
 DOLocationID BIGINT,
 PaymentType BIGINT,
 FareAmount FLOAT,
 Extra FLOAT,
 mta_tax FLOAT,
 tip_amount FLOAT,
 tolls_amount FLOAT,
 improvement_surcharge FLOAT,
 TotalAmount FLOAT,
 congestion_surcharge FLOAT)
WITH
(
    DISTRIBUTION = HASH(VendorID, RatecodeID, PULocationID, DOLocationID),
    CLUSTERED COLUMNSTORE INDEX
);

INSERT INTO dbo.FactYellowTaxis
SELECT  yt.VendorID,
        yt.tpep_pickup_datetime,
        yt.tpep_dropoff_datetime,
        yt.passenger_count as passengerCount,
        yt.trip_distance as tripDistance,
        yt.RatecodeID,
        yt.store_and_fwd_flag,
        yt.PULocationID,
        yt.DOLocationID,
        yt.payment_type as PaymentType,
        yt.fare_amount as FareAmount,
        yt.extra as Extra,
        yt.mta_tax,
        yt.tip_amount,
        yt.tolls_amount,
        yt.improvement_surcharge,
        yt.total_amount as TotalAmount,
        yt.congestion_surcharge
FROM dbo.YellowTaxies yt;

Select TOP 100 *
FROM dbo.FactYellowTaxis;
