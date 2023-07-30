
--query to determine if days immediately preceding precipitation or snow had more bike trips on average than the days with precipitation or snow.

-- daily bike trip counts
-- this CTE can be merged with the next one
WITH daily_bike_trips AS (
    SELECT 
        date,
        trips
    FROM 
        {{ref('mart__fact_all_trips_daily') }}
    WHERE type = 'bike'
),
-- daily trip count + weather + weather the next day
daily_trip_count_weather AS (
    SELECT
        daily_bike_trips.date,
        daily_bike_trips.trips,
        weather.prcp,
        weather.snow,
        LEAD(prcp) OVER (ORDER BY weather.date) as next_day_prcp,
        LEAD(snow) OVER (ORDER BY weather.date) as next_day_snow
    FROM daily_bike_trips
    JOIN {{ ref('stg_main__central_park_weather')}} weather
    ON daily_bike_trips.date = weather.date
)

SELECT 
    -- prcp > 0 or snow > 0 for a day with precipitation or snow
    (SELECT AVG(trips) FROM daily_trip_count_weather WHERE prcp > 0 or snow > 0) as avg_bad_weather_trip_count, 
    -- prcp = 0 and snow = 0 and (next_day_prcp > 0 or next_day_snow > 0 for a good weather day but snow or precipation the next day
    (SELECT AVG(trips) FROM daily_trip_count_weather WHERE prcp = 0 and snow = 0 and (next_day_prcp > 0 or next_day_snow > 0)) as avg_preceding_day_trip_count
