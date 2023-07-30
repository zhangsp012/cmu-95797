

-- Alternative way to get average_time_between_pickups. Looks terrible but can actually run and get results on my machine
-- it will create a temperarory table, run query zone by zone, and insert the results into the table
-- in the end, it will print out the table

-- depends_on: {{ ref('mart__fact_all_taxi_trips') }}
-- depends_on: {{ ref('mart__dim_locations') }}

{% set zones = dbt_utils.get_column_values(table=ref('mart__dim_locations'), column='zone') %}

-- Create temporary table before the loop
CREATE TEMPORARY TABLE average_time_between_pickup (
    zone VARCHAR,
    average_time_between_pickups DECIMAL
);


{% for zone in zones %}

WITH zone_wait_time AS (
    SELECT
        location.zone,
        datediff( 'minute', 
            LAG(taxi_trip.pickup_datetime) OVER (
                ORDER BY taxi_trip.pickup_datetime), 
            taxi_trip.pickup_datetime
        ) AS time_between_pickups
    FROM 
        {{ ref('mart__fact_all_taxi_trips') }} taxi_trip
    JOIN  
        {{ ref('mart__dim_locations') }} location
    ON 
        taxi_trip.pulocationid = location.locationid
    WHERE location.zone = '{{ zone | replace("'", "''") }}'
)

-- Insert into the temporary table instead of standalone SELECT
INSERT INTO average_time_between_pickup
SELECT
    zone,
    AVG(time_between_pickups) as average_time_between_pickups
FROM 
    zone_wait_time
GROUP BY 
    zone;
{% endfor %}

-- After the loop, select everything from the table
SELECT *
FROM average_time_between_pickup;

-- Drop the table at the end
DROP TABLE average_time_between_pickup;


