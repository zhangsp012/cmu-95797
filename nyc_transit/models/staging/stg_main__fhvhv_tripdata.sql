-- some garabage data are removed by the where statment
with source as (

    select * from {{ source('main', 'fhvhv_tripdata') }}

),

renamed as (

    select
        hvfhs_license_num,
        dispatching_base_num,
        originating_base_num,
        request_datetime,
        on_scene_datetime,
        pickup_datetime,
        dropoff_datetime,
        pulocationid,
        dolocationid,
        trip_miles,
        trip_time,
        base_passenger_fare,
        tolls,
        bcf,
        sales_tax,
        congestion_surcharge,
        airport_fee,
        tips,
        driver_pay,
        {{ str_to_bool('shared_request_flag') }} as shared_request_flag,
        {{ str_to_bool('shared_match_flag') }} as shared_match_flag,
        {{ str_to_bool('access_a_ride_flag') }} AS access_a_ride_flag,
        {{ str_to_bool('wav_request_flag') }} as wav_request_flag,
        {{ str_to_bool('wav_match_flag') }} as wav_match_flag,
        filename

    from source
)

select * from renamed

