
with source as (

    select * from {{ source('main', 'fhvhv_tripdata') }}

),

renamed as (

    select
        hvfhs_license_num,
        -- actions below to make sure all base_num in consistent format
        -- This actually does not have any impact on this batch of data
        -- Many data is still missing proper foreign keys
        trim(upper(dispatching_base_num)) as dispatching_base_num,
        trim(upper(originating_base_num)) as originating_base_num,
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

