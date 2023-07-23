SELECT
    count(*) as total_trips,
FROM {{ ref('mart__fact_all_taxi_trips')}} 
JOIN {{ ref('mart__dim_locations') }}
-- locationID does not contain null
ON dolocationid = locationID
WHERE service_zone in ('EWR', 'Airports')