--F2 Regresion de la propina

CREATE OR REPLACE MODEL `seminariosistemas2.nyc_taxi.fase2_tipamount_linreg`
OPTIONS(
  MODEL_TYPE = 'LINEAR_REG',
  INPUT_LABEL_COLS = ['fare_amount']
) AS
SELECT
  --tip_amount,
  hour_of_day, dow, month,
  trip_distance, total_amount, fare_amount, passenger_count,
  pickup_loc, dropoff_loc
FROM `seminariosistemas2.nyc_taxi.v_features_train`;

CREATE OR REPLACE TABLE `seminariosistemas2.nyc_taxi.eval_tipamount_linreg` AS
SELECT *
FROM ML.EVALUATE(
  MODEL `seminariosistemas2.nyc_taxi.fase2_tipamount_linreg`,
  (
    SELECT
      --fare_amount,
      hour_of_day, dow, month,
      trip_distance, total_amount, fare_amount, passenger_count,
      pickup_loc, dropoff_loc
    FROM `seminariosistemas2.nyc_taxi.v_features_test`
  )
);