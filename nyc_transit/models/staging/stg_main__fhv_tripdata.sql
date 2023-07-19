-- SR_Flag column was dropped from the raw data since it only has null
with source as (

    select * from {{ source('main', 'fhv_tripdata') }}

),

renamed as (

    select
        -- clean up the dispatching_base_num and affliated_base_number to properly link to base_number in stg_main_fhv_bases
        -- This can only fix part of the issue, many records still missing foreign keys
        trim(upper(dispatching_base_num)) as  dispatching_base_num,
        pickup_datetime,
        dropoff_datetime,
        pulocationid,
        dolocationid,
        trim(upper(affiliated_base_number)) as affiliated_base_number,
        filename

    from source

)

select * from renamed

