-- LOGISTIC
CREATE OR REPLACE TABLE `seminariosistemas2.nyc_taxi.eval_tipped_logistic` AS
SELECT *
FROM ML.EVALUATE(
  MODEL `seminariosistemas2.nyc_taxi.fase2_tipped_logistic`,
  (
    SELECT
      tipped,
      hour_of_day, dow, month,
      trip_distance, total_amount, fare_amount, passenger_count,
      pickup_loc, dropoff_loc
    FROM `seminariosistemas2.nyc_taxi.v_features_test`
  )
);

-- BOOSTED TREE
CREATE OR REPLACE TABLE `seminariosistemas2.nyc_taxi.eval_tipped_btree` AS
SELECT *
FROM ML.EVALUATE(
  MODEL `seminariosistemas2.nyc_taxi.fase2_tipped_btree`,
  (
    SELECT
      tipped,
      hour_of_day, dow, month,
      trip_distance, total_amount, fare_amount, passenger_count,
      pickup_loc, dropoff_loc
    FROM `seminariosistemas2.nyc_taxi.v_features_test`
  )
);


SELECT 'LOGISTIC' AS model,
       roc_auc, accuracy, precision, recall, f1_score, log_loss
FROM `seminariosistemas2.nyc_taxi.eval_tipped_logistic`
UNION ALL
SELECT 'BTREE' AS model,
       roc_auc, accuracy, precision, recall, f1_score, log_loss
FROM `seminariosistemas2.nyc_taxi.eval_tipped_btree`
ORDER BY model;