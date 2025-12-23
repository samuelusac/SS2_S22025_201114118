--Variables Categoricas

--Metodos de pago
SELECT
  payment_type,
  COUNT(*) AS total_viajes 
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022` 
GROUP BY payment_type
ORDER BY total_viajes DESC;

--Cantidad de pasajeros
SELECT
  passenger_count,
  COUNT(*) AS total_viajes
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
GROUP BY passenger_count
ORDER BY passenger_count;

--Patrones temporales
SELECT
  AVG(TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, MINUTE)) AS avg_duration_min,
  MIN(TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, MINUTE)) AS min_duration_min,
  MAX(TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, MINUTE)) AS max_duration_min
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
WHERE dropoff_datetime IS NOT NULL
  AND pickup_datetime IS NOT NULL;

  -- Deteccion de Patrones Temporales  
-- MES 
SELECT 
 EXTRACT(MONTH FROM pickup_datetime) AS mes, 
 COUNT(*) AS total_viajes 
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
GROUP BY mes 
ORDER BY mes; 

-- DIA 
SELECT 
 EXTRACT(DAYOFWEEK FROM pickup_datetime) AS dia_semana, 
 COUNT(*) AS total_viajes 
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
GROUP BY dia_semana 
ORDER BY dia_semana;

-- DIA 
SELECT 
 EXTRACT(HOUR FROM pickup_datetime) AS horita, 
 COUNT(*) AS total_viajes 
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
GROUP BY horita 
ORDER BY horita;
