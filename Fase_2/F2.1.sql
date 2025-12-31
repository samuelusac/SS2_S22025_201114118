--F2 1

CREATE OR REPLACE TABLE `seminariosistemas2.nyc_taxi.trips_q1_features`
PARTITION BY DATE(pickup_datetime)
CLUSTER BY pickup_datetime AS
SELECT
  -- Label
  CASE WHEN tip_amount > 0 THEN 1 ELSE 0 END AS tipped,
  -- Señales temporales
  EXTRACT(HOUR FROM pickup_datetime) AS hour_of_day,
  EXTRACT(DAYOFWEEK FROM pickup_datetime) AS dow,         -- 1=Domingo
  EXTRACT(DAY FROM pickup_datetime) AS day,
  EXTRACT(MONTH FROM pickup_datetime) AS month,
  -- Magnitudes
  trip_distance,
  total_amount,
  fare_amount,
  passenger_count,
  -- Señales de ubicación (como claves categóricas)
  CAST(pickup_location_id AS STRING) AS pickup_loc,
  CAST(dropoff_location_id AS STRING) AS dropoff_loc,
  -- Conservamos timestamp para partición/segmentación
  pickup_datetime
FROM `seminariosistemas2.nyc_taxi.yellow_2022_clean`
WHERE DATE(pickup_datetime) BETWEEN '2022-01-01' AND '2022-03-31'
  AND trip_distance > 0
  AND total_amount >= 0
  AND fare_amount >= 0
  AND passenger_count BETWEEN 1 AND 6;