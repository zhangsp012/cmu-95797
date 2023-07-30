
-- number of trips grouped by pick up location borough
SELECT location.borough, COUNT(*) AS trip_count
FROM {{ ref('mart__fact_all_taxi_trips')}} 
JOIN {{ ref('mart__dim_locations')}} AS location
ON PulocationID = location.locationID
GROUP BY borough
