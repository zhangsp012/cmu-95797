
with source as (

    select * from {{ source('main', 'daily_citi_bike_trip_counts_and_weather') }}

),

renamed as (

    select
        date:: date as date,
        trips:: int as trips,
        precipitation:: double as precipitation,
        snow_depth:: double as snow_depth,
        snowfall:: double as snowfall,
        max_temperature:: double as max_temperature,
        min_temperature:: double as min_temperature,
        TRY_CAST(average_wind_speed AS double) as average_wind_speed,
        dow:: int as dow,
        year:: int as year,
        month:: int as month,
        holiday:: boolean as holiday,
        stations_in_service,
        weekday:: boolean as weekday,
        weekday_non_holiday:: boolean as weekday_non_holiday,
        filename

    from source

)

select * from renamed

