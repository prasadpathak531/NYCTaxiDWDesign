

SELECT month(lpep_pickup_datetime) as months, 
year(lpep_pickup_datetime) as years,count(year(lpep_pickup_datetime)) as counts from factgreentaxi
WHERE month(lpep_pickup_datetime) BETWEEN 9 and 12 and  year(lpep_pickup_datetime) = 2019
group by month(lpep_pickup_datetime),year(lpep_pickup_datetime) order by years,months



SELECT month(tpep_pickup_datetime) as months,
year(tpep_pickup_datetime) as years,count(year(tpep_pickup_datetime)) as counts from factyellowtaxi
WHERE month(tpep_pickup_datetime) BETWEEN 9 and 12 and  year(tpep_pickup_datetime) = 2019
group by month(tpep_pickup_datetime),year(tpep_pickup_datetime) order by years,months



