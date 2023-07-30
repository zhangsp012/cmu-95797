
-- finds taxi trips which don’t have a pick up location_id in the locations table
SELECT taxi_trip.*
FROM {{ ref('mart__fact_all_taxi_trips')}} taxi_trip
LEFT JOIN {{ ref('mart__dim_locations')}} location
ON taxi_trip.PulocationID = location.locationID 
WHERE location.locationID is NULL
