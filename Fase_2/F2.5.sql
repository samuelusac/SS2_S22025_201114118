--5) Entrenamiento con BigQuery ML (2 modelos mínimos)

--Regresión Logística (clasificación)

CREATE OR REPLACE MODEL `seminariosistemas2.nyc_taxi.fase2_tipped_logistic`
OPTIONS(
  MODEL_TYPE = 'LOGISTIC_REG',
  INPUT_LABEL_COLS = ['tipped'],
  AUTO_CLASS_WEIGHTS = TRUE,
  L1_REG = 0.0,
  L2_REG = 1.0
) AS
SELECT
  tipped,
  hour_of_day, dow, month,
  trip_distance, total_amount, fare_amount, passenger_count,
  pickup_loc, dropoff_loc
FROM `seminariosistemas2.nyc_taxi.v_features_train`;

--Árbol Potenciado (Boosted Tree Classifier)

CREATE OR REPLACE MODEL `seminariosistemas2.nyc_taxi.fase2_tipped_btree`
OPTIONS(
  MODEL_TYPE = 'BOOSTED_TREE_CLASSIFIER',
  INPUT_LABEL_COLS = ['tipped'],
  NUM_PARALLEL_TREE = 1,
  MAX_TREE_DEPTH = 6,
  SUBSAMPLE = 0.8,
  MAX_ITERATIONS = 30,
  MIN_TREE_CHILD_WEIGHT = 1
) AS
SELECT
  tipped,
  hour_of_day, dow, month,
  trip_distance, total_amount, fare_amount, passenger_count,
  pickup_loc, dropoff_loc
FROM `seminariosistemas2.nyc_taxi.v_features_train`;