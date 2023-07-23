
SELECT 'bike' as type, started_at_ts, ended_at_ts, duration_min, duration_sec FROM {{ ref('mart__fact_all_bike_trips')}}
UNION ALL
SELECT type, pickup_datetime as started_at_ts, dropoff_datetime as ended_at_ts, duration_min, duration_sec FROM {{ ref('mart__fact_all_taxi_trips')}}