
--calculate the 7 day moving average precipitation for every day in the weather data
SELECT *, AVG(prcp)
OVER (
    ORDER BY date
    RANGE BETWEEN INTERVAL 3 DAYS PRECEDING AND
    INTERVAL 3 DAYS FOLLOWING
) AS seven_day_average_prcp
FROM {{ ref('stg_main__central_park_weather')}}