SELECT
    DISTINCT
    -- in the current stage, station_id is not unique. Some records have the same id, name but different lat and lng
    start_station_id as station_id,
    start_station_name as station_name,
    -- the code below will help to remove some duplicate records due to data formatting issue
    -- precision of 6 for lat and lng is roughly precision of 1 meter
    round(start_lat, 6) as station_lat,
    round(start_lng, 6) as station_lng,
FROM {{ref('stg_main__bike_data')}}
UNION
SELECT
    DISTINCT
    end_station_id as station_id,
    end_station_name as station_name,
    -- precision of 6 for lat and lng is roughly precision of 1 meter
    round(end_lat, 6) as station_lat,
    round(end_lng, 6) as station_lng
FROM {{ ref('stg_main__bike_data')}}