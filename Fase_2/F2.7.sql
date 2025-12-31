-- Predicciones con el mejor modelo (ej.: BTREE)
CREATE OR REPLACE TABLE `seminariosistemas2.nyc_taxi.pred_tipped_btree_test` AS
SELECT
  p.* EXCEPT (predicted_tipped),
  p.predicted_tipped AS tipped_pred,            -- clase predicha (0/1)
  p.predicted_tipped_probs[OFFSET(1)] AS p_yes, -- probabilidad de tipped=1
  f.pickup_datetime,
  f.pickup_loc AS pl2, f.dropoff_loc AS dl2, f.hour_of_day AS hd2, f.dow AS dow2, f.month AS m2,
  f.trip_distance AS td2, f.total_amount AS ta2, f.fare_amount AS fa2, f.passenger_count as pc2,
  f.tipped AS tipped_real
FROM ML.PREDICT(
  MODEL `seminariosistemas2.nyc_taxi.fase2_tipped_btree`,
  (
    SELECT
      tipped,
      hour_of_day, dow, month,
      trip_distance, total_amount, fare_amount, passenger_count,
      pickup_loc, dropoff_loc
    FROM `seminariosistemas2.nyc_taxi.v_features_test`
  )
) AS p
JOIN `seminariosistemas2.nyc_taxi.v_features_test` AS f
ON TRUE
QUALIFY ROW_NUMBER() OVER () = ROW_NUMBER() OVER (); -- empareja filas 1:1

-- Curva precisión/recall por umbral
SELECT *
FROM ML.ROC_CURVE(
  MODEL `seminariosistemas2.nyc_taxi.fase2_tipped_btree`,
  TABLE `seminariosistemas2.nyc_taxi.v_features_test`
);
