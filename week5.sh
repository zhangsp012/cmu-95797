#!/bin/bash
set -x

#!/bin/bash

# Define the database and answers directory
DATABASE="../main.db"
ANSWERS_DIR="../answers"

# Execute each SQL script and output the results to the corresponding text file
duckdb $DATABASE -s '.read ./target/compiled/nyc_transit/analyses/trips_duration_grouped_by_borough_zone.sql' > $ANSWERS_DIR/trips_duration_grouped_by_borough_zone.txt
duckdb $DATABASE -s '.read ./target/compiled/nyc_transit/analyses/taxi_trips_no_valid_pickup_location_id.sql' > $ANSWERS_DIR/taxi_trips_no_valid_pickup_location_id.txt
duckdb $DATABASE -s '.read ./target/compiled/nyc_transit/analyses/zones_with_less_than_100k_trips.sql' > $ANSWERS_DIR/zones_with_less_than_100k_trips.txt
duckdb $DATABASE -s '.read ./target/compiled/nyc_transit/analyses/pivot_trips_by_borough.sql' > $ANSWERS_DIR/pivot_trips_by_borough.txt
duckdb $DATABASE -s '.read ./target/compiled/nyc_transit/analyses/yellow_taxi_fare_comparison.sql' > $ANSWERS_DIR/yellow_taxi_fare_comparison.txt
duckdb $DATABASE -s '.read ./target/compiled/nyc_transit/analyses/dedupe.sql' > $ANSWERS_DIR/dedupe.txt
duckdb $DATABASE -s '.read ./target/compiled/nyc_transit/analyses/seven_day_moving_average_prcp.sql' > $ANSWERS_DIR/seven_day_moving_average_prcp.txt
duckdb $DATABASE -s '.read ./target/compiled/nyc_transit/analyses/seven_day_moving_aggs_weather.sql' > $ANSWERS_DIR/seven_day_moving_aggs_weather.txt
duckdb $DATABASE -s '.read ./target/compiled/nyc_transit/analyses/average_time_between_pickups_alternative.sql' > $ANSWERS_DIR/average_time_between_pickups_alternative.txt
duckdb $DATABASE -s '.read ./target/compiled/nyc_transit/analyses/days_before_precip_more_bike_trips.sql' > $ANSWERS_DIR/days_before_precip_more_bike_trips.txt

