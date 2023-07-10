-- tripduraction column has been dropped since it can be derived from other columns

with source as (

    select * from {{ source('main', 'bike_data') }}

),

renamed as (

    select
        COALESCE(starttime, started_at):: timestamp as started_at,
        COALESCE(stoptime, ended_at):: timestamp as ended_at,
        COALESCE("start station id", start_station_id) as start_station_id,
        COALESCE("start station name", start_station_name) as start_station_name,
        COALESCE("start station latitude", start_lat):: double as start_lat,
        COALESCE("start station longitude", start_lng):: double as start_lng,
        COALESCE("end station id", end_station_id) as end_station_id,
        COALESCE("end station name", end_station_name) as end_station_name,
        COALESCE("end station latitude", end_lat):: double as end_lat,
        COALESCE("end station longitude", end_lng):: double as end_lng,
        bikeid:: int as bikeid,
        usertype,
        "birth year":: int as birth_year,
        gender:: int as gender,
        ride_id,
        rideable_type,
        member_casual,
        filename

    from source

)

select * from renamed

