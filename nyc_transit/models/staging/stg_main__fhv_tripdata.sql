-- SR_Flag column was dropped from the raw data since it only has null
with source as (

    select * from {{ source('main', 'fhv_tripdata') }}

),

renamed as (

    select
        dispatching_base_num,
        pickup_datetime,
        dropoff_datetime,
        pulocationid,
        dolocationid,
        affiliated_base_number,
        filename

    from source

)

select * from renamed

