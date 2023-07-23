with trips_renamed as
(

    SELECT 'fhv' as type, pickup_datetime, dropoff_datetime, pulocationid, dolocationid
    FROM {{ ref('stg_main__fhv_tripdata')}}
    UNION ALL
    SELECT 'fhvhv' as type, pickup_datetime, dropoff_datetime, pulocationid, dolocationid
    FROM {{ ref('stg_main__fhvhv_tripdata')}}
    UNION ALL
    SELECT 'green' as type, lpep_pickup_datetime as pickup_datetime, lpep_dropoff_datetime as dropoff_datetime, pulocationid, dolocationid
    FROM {{ ref('stg_main__green_tripdata')}}
    UNION ALL
    SELECT 'yellow' as type, tpep_pickup_datetime as pickup_datetime, tpep_dropoff_datetime as dropoff_datetime, pulocationid, dolocationid
    FROM {{ ref('stg_main__yellow_tripdata')}}

)

SELECT
    type,
    pickup_datetime,
    dropoff_datetime,
    -- set abnormal data to null
    CASE 
        WHEN datediff('minute', pickup_datetime, dropoff_datetime) BETWEEN 0 AND 9000
        THEN datediff('minute', pickup_datetime, dropoff_datetime) 
        ELSE NULL 
    END as duration_min,
    CASE 
        WHEN datediff('second', pickup_datetime, dropoff_datetime) BETWEEN 0 AND 540000
        THEN datediff('second', pickup_datetime, dropoff_datetime) 
        ELSE NULL 
    END as duration_sec,
    pulocationid,
    dolocationid,
FROM trips_renamed