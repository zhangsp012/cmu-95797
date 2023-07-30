
-- query to compare an individual fare to the zone, borough and overall average fare using the fare_amount in yellow taxi trip data
SELECT
    yellow.fare_amount AS individual_fare,
    location.borough,
    location.zone,
    AVG(yellow.fare_amount) OVER () AS overall_avg_fare,
    AVG(yellow.fare_amount) OVER (PARTITION BY location.borough) AS borough_avg_fare,
    AVG(yellow.fare_amount) OVER (PARTITION BY location.zone) AS zone_avg_fare
    -- I did not includes these deritive columns but it can be done
    -- individual_fare - overall_avg_fare as diff_overall
    -- individual_fare - borough_avg_fare as diff_borough
    -- individual_fare - zone_avg_fare as diff_zone
FROM {{ ref('stg_main__yellow_tripdata')}} yellow
JOIN {{ ref('mart__dim_locations')}} location
ON yellow.pulocationid = location.locationid
-- the staging data contains fare_amount range from $-1300 to ~ $1 millon, filtering out the questionable data
-- negative value may make sense as a overcharge refund
WHERE yellow.fare_amount BETWEEN -500 AND 10000
