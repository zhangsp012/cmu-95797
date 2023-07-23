WITH all_trips AS (
    SELECT 
        weekday(pickup_datetime) as weekday,
        count(*) as num_trips,
        pulocationid,
        dolocationid
    FROM 
        {{ ref('mart__fact_all_taxi_trips') }}
    GROUP BY ALL
),
total_trips AS (
    SELECT
        weekday,
        SUM(num_trips) AS total_trip
    FROM
        all_trips
    GROUP BY weekday
),
inter_borough_trips AS (
    SELECT 
        a.weekday,
        SUM(a.num_trips) AS num_inter_borough_trips
    FROM 
        all_trips a
    -- note: total trips counts all trips including null pick or droff location id records
    -- inter borough trips only count trips with pickup and dropoff location id not null since locationid does not contain null (checked by dbt tests)
    JOIN 
        {{ref('mart__dim_locations')}} lp ON a.pulocationid = lp.locationid
    JOIN 
        {{ref('mart__dim_locations')}} ld ON a.dolocationid = ld.locationid
    WHERE 
        lp.borough != ld.borough
    GROUP BY 
        a.weekday
)

SELECT 
    ibt.weekday,
    ibt.num_inter_borough_trips,
    tt.total_trip,
    COALESCE(ibt.num_inter_borough_trips, 0) * 100.0 / NULLIF(tt.total_trip, 0) AS percent_inter_borough_trips
FROM  
    inter_borough_trips AS ibt
LEFT JOIN 
    total_trips AS tt ON ibt.weekday = tt.weekday
ORDER BY 
    ibt.weekday;