--F2 2

CREATE OR REPLACE VIEW `seminariosistemas2.nyc_taxi.v_features_train` AS
SELECT *
FROM `seminariosistemas2.nyc_taxi.trips_q1_features`
WHERE DATE(pickup_datetime) BETWEEN '2022-01-01' AND '2022-02-28';

CREATE OR REPLACE VIEW `seminariosistemas2.nyc_taxi.v_features_test` AS
SELECT *
FROM `seminariosistemas2.nyc_taxi.trips_q1_features`
WHERE DATE(pickup_datetime) BETWEEN '2022-03-01' AND '2022-03-31';