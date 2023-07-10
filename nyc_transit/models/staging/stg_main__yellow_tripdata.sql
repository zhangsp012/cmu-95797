
with source as (

    select * from {{ source('main', 'yellow_tripdata') }}

),
-- some garabage data are removed by the where statment
renamed as (

    select
        vendorid,
        tpep_pickup_datetime,
        tpep_dropoff_datetime,
        passenger_count::int as passenger_count,
        trip_distance,
        ratecodeid,
        {{ str_to_bool('store_and_fwd_flag') }} store_and_fwd_flag,
        pulocationid,
        dolocationid,
        payment_type,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        improvement_surcharge,
        total_amount,
        congestion_surcharge,
        airport_fee,
        filename

    from source
    WHERE passenger_count > 0 and passenger_count < 10 
    and trip_distance > 0 and trip_distance < 1000 
    and fare_amount > 0 and tip_amount >=0  and tolls_amount >= 0 and total_amount < 3000 
    and tpep_dropoff_datetime > tpep_pickup_datetime and tpep_dropoff_datetime < current_date

)

select * from renamed

