
--finds all the Zones where there are less than 100000 trips.
SELECT location.zone, COUNT(*) AS trip_count
FROM {{ ref('mart__fact_all_taxi_trips')}} AS taxi_trip
JOIN {{ ref('mart__dim_locations')}} AS location
ON taxi_trip.PulocationID = location.locationID
GROUP BY ALL
HAVING trip_count < 100000
