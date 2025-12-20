--1. Conectarse al dataset público


SELECT 
  COUNT(*) AS total_viajes
FROM 
  `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`;