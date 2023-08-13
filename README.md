# cmu-95797-23m6

## Week 1
### Objectives
-- Install and setup
-- Project data (browsable): s3://cmu-95797-23m6
-- Use awscli to download project data
-- Load data to duckDB
-- Verify row counts w/ duckdb CLI

## Week 1 File
- `week1.sh` bash script to automate the scripts below
-  `sql/ingest.sql:`  scripts to ingest all data
-   `sql/dump_raw_schemas.sql:`  print out table names and schemas 
-   `scripts/dump_raw_counts.py:` print out  `table_name row_count`
-   `answers/raw_counts.txt:` result of running  `dump_raw_counts.py`
-   `answers/raw_schemas.txt:` result of running  `dump_raw_schemas.sql`
## Week 1 Notes
- `main.db` which contains all project data is not commited to this repo due to its large size

## Week 2 Notes
- Initialize a dbt project
- Add a dbt connection profile for our duckdb database
- Install dbt packages, specifically dbt-codegen
- Add ingested raw data as dbt sources using dbt-codegen
- Create staging models with cleaned up data
    - renamed columns
    - cast data types
    - drop useless columns
    - unify schemas (bike data)
    - remove garbage records

## Week 3 Notes

-  Add dbt tests & documentation to sources.yml
- Create a schema.yml for staging using dbt-codegen’s
- Add dbt tests & documentation for staging models
- Do dbt build to run models and tests
- Adjust tests and/or fix problems in models
- submitted screenshots in answers/

## Week 4 Notes
created following mart tables
- mart__fact_all_bike_trips
- mart__fact_all_taxi_trips
- mart__fact_all_trips_daily
- mart__fact_all_trips
- mart__dim_bike_stations
- mart__dim_locations

Performed following analyses:
- bike_trips_and_duration_by_weekday.sql - count & total time of bikes trips by weekday
- taxi_trips_ending_at_airport.sql - total number of trips ending in service_zones 'Airports' or 'EWR'
- inter_borough_taxi_trips_by_weekday.sql : by weekday, count of total trips, trips starting and ending in a different borough, and percentage w/ different start/end

Results of the analyses above are stored in answers/

## Week 5 Notes:

created analysis queries to do the following

- Add a new seed from events.csv
- Add a new fact table mart__fact_trips_by_borough.sql
- rips_duration_grouped_by_borough_zone.sql
	Calculate the number of trips and average duration by borough and zone

- taxi_trips_no_valid_pickup_location_id.sql
	finds taxi trips which don’t have a pick up location_id in the locations table.
	
- zones_with_less_than_100k_trips.sql
	finds all the Zones where there are less than 100000 trips.
- pivot_trips_by_borough.sql
	a query to pivot the results by borough.
- yellow_taxi_fare_comparison.sql
	Query to compare an individual fare to the zone, borough and overall average fare using the fare_amount in yellow taxi trip data.
- dedupe.sql
	Use Window functions with QUALIFY and ROW_NUMBER to remove duplicate rows.
	Prefer rows with a later time stamp
- seven_day_moving_average_prcp.sql
	Calculate the 7 day moving average precipitation for every day in the weather data. 
- seven_day_moving_aggs_weather.sql
 Calculate the 7 day moving min, max, avg, sum for precipitation and snow for every day in the weather data, defining the window only once.
 - average_time_between_pickups.sql
Find the average time between taxi pick ups per zone
- days_before_precip_more_bike_trips.sql
 determine if days immediately preceding precipitation or snow had more bike trips on average than the days with precipitation or snow.

 ## Week 6 Notes:

-   Conducted in-depth data analytics to NYC Transit data.
-   Generated reports using the "Evidence" reporting tool, incorporating embedded SQL for data extraction and visualization. 
- Screenshots of the analysis report are under answers, file name report_webpage#*
-   Deployed the report on a webpage hosted by an Nginx server within a Docker container. This container was hosted on an AWS EC2 instance. 
- The Nginx server was secured using TLS, incorporating the Diffie-Hellman key exchange for enhanced security.
- The Nginx server conf file and dockerfile are under the root folder for reference