-- This file is suggested by the assignment requirement, however it will output the whole table to the text file so it is basically unusable.
-- I used the bash scripts weeek5.sh instead
.echo on

.once ../an swers/trips_duration_grouped_by_borough_zone.txt
.read target/compiled/nyc_transit/analyses/trips_duration_grouped_by_borough_zone.sql

.once ../answers/taxi_trips_no_valid_pickup_location_id.txt
.read target/compiled/nyc_transit/analyses/taxi_trips_no_valid_pickup_location_id.sql

.once ../answers/zones_with_less_than_100k_trips.txt
.read target/compiled/nyc_transit/analyses/zones_with_less_than_100k_trips.sql

.once ../answers/pivot_trips_by_borough.txt
.read target/compiled/nyc_transit/analyses/pivot_trips_by_borough.sql

.once ../answers/yellow_taxi_fare_comparison.txt
.read target/compiled/nyc_transit/analyses/yellow_taxi_fare_comparison.sql

.once ../answers/dedupe.txt
.read target/compiled/nyc_transit/analyses/dedupe.sql

.once ../answers/seven_day_moving_average_prcp.txt
.read target/compiled/nyc_transit/analyses/seven_day_moving_average_prcp.sql

.once ../answers/seven_day_moving_aggs_weather.txt
.read target/compiled/nyc_transit/analyses/seven_day_moving_aggs_weather.sql

.echo off
.once ../answers/average_time_between_pickups_alternatives.txt
-- The sql below may not work due to hardware limitation, use the alternatives instead
--.read target/compiled/nyc_transit/analyses/average_time_between_pickups.sql
.read target/compiled/nyc_transit/analyses/average_time_between_pickups_alternatives.sql

.echo on
.once ../answers/days_before_precip_more_bike_trips.txt
.read target/compiled/nyc_transit/analyses/days_before_precip_more_bike_trips.sql