# Seminario de sistemas 2, Proyecto Fase 1

## 1. Conectarse al dataset público:

1. Entra a [Google Cloud Console](https://console.cloud.google.com/) e inicia sesión.
2. Crear nuevo proyecto,  **Project selector** → **New Project**
3. SELECT al Data Set

<div align="center">
  <img src="img/01.png" alt="BQ01"/>
</div>

## 2. Realizar consultas SQL 

### -Información del dataset

Ejecutamos la siguente consulta para revisar la información de las columnas y sus tipos de datos:

   ```sql
    SELECT
        column_name,
        data_type
    FROM `bigquery-public-data.new_york_taxi_trips.INFORMATION_SCHEMA.COLUMNS`
        WHERE table_name = 'tlc_yellow_trips_2022';
   ```


<div align="center">
  <img src="img/02.png" alt="BQ02"/>
</div>

### -Limpieza de datos

Ejecutamos la siguente consulta para revisar la limpieza de los datos:

   ```sql
    SELECT
        COUNTIF(passenger_count IS NULL) AS nulos_pasajeros,
        COUNTIF(trip_distance IS NULL) AS nulos_distancia,
        COUNTIF(total_amount IS NULL) AS nulos_total
    FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`;
   ```


<div align="center">
  <img src="img/03.png" alt="BQ03"/>
</div>


## 3. Optimización con particiones y clustering

Ejecutamos la siguente consulta para crear el esquema y la tabla derivada:

   ```sql
--Creación del esquema o tabla

CREATE SCHEMA IF NOT EXISTS `seminariosistemas2.nyc_taxi`;

--Creacion de tabla derivada

CREATE OR REPLACE TABLE `seminariosistemas2.nyc_taxi.yellow_2022_subset` AS
    SELECT
        pickup_datetime,
        dropoff_datetime,
        pickup_location_id,
        dropoff_location_id,
        passenger_count,
        trip_distance,
        fare_amount,
        tip_amount,
        total_amount,
        payment_type
    FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
        WHERE pickup_datetime IS NOT NULL
        AND dropoff_datetime IS NOT NULL;
   ```


<div align="center">
  <img src="img/04.png" alt="BQ04"/>
</div>