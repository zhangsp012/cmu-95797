SELECT
    started_at_ts,
    ended_at_ts,
    -- set abnormal data to null
    CASE 
        WHEN datediff('minute', started_at_ts, ended_at_ts) BETWEEN 0 AND 9000
        THEN datediff('minute', started_at_ts, ended_at_ts) 
        ELSE NULL 
    END as duration_min,
    CASE 
        WHEN datediff('second', started_at_ts, ended_at_ts) BETWEEN 0 AND 540000
        THEN datediff('second', started_at_ts, ended_at_ts) 
        ELSE NULL 
    END as duration_sec,
    start_station_id,
    end_station_id
FROM {{ ref('stg_main__bike_data')}}