

--calculate the 7 day moving min, max, avg, sum for precipitation and snow for every day in the weather data
SELECT 
    station, 
    name, 
    date, 
    prcp, 
    snow, 
    snwd,
    {{ calculate_window_day_metrics('prcp', 'seven_days') }},
    {{ calculate_window_day_metrics('snow', 'seven_days') }},
    {{ calculate_window_day_metrics('snwd', 'seven_days') }}
FROM {{ ref('stg_main__central_park_weather') }} weather
WINDOW seven_days AS (
    ORDER BY date
    RANGE BETWEEN INTERVAL 3 DAYS PRECEDING 
    AND INTERVAL 3 DAYS FOLLOWING
)
