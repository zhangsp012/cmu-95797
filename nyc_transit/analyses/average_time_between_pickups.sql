

-- Find the average time between taxi pick ups per zone
-- Use lead or lag to find the next trip per zone for each record
-- then find the time difference between the pick up time for the current record and the next
-- then use this result to calculate the average time between pick ups per zone.


WITH zone_wait_time AS (
    SELECT
        location.zone,
        -- this sql did not run on my mac. tried to break this down to multiple CTE but the LAG() function on the whole joined table causes issues.
        -- calculate time difference between this trip and previous trip
        datediff( 'minute', LAG(taxi_trip.pickup_datetime) OVER (
                PARTITION BY location.zone
                ORDER BY taxi_trip.pickup_datetime), 
            taxi_trip.pickup_datetime
        ) AS time_between_pickups
    FROM 
        {{ ref('mart__fact_all_taxi_trips') }} taxi_trip
    JOIN  
        {{ ref('mart__dim_locations') }} location
    ON 
        taxi_trip.pulocationid = location.locationid

)

SELECT
    zone,
    AVG(time_between_pickups) as average_time_between_pickups
FROM 
    zone_wait_time
GROUP BY 
    zone
