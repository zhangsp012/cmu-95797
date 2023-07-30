
-- Calculate the number of trips and average duration by borough and zone
SELECT location.borough, location.zone, COUNT(*) AS trip_count, ROUND(avg(duration_min), 2) AS average_trip_duration_min
FROM {{ ref('mart__fact_all_taxi_trips')}} AS taxi_trip
JOIN {{ ref('mart__dim_locations')}} AS location
ON taxi_trip.PulocationID = location.locationID
GROUP BY ALL
