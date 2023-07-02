.echo on
-- The DROP TABLE Statements below is just to avoid duplication, not needed if starting with a new database
DROP TABLE bike_data;
DROP TABLE central_park_weather;
DROP TABLE daily_citi_bike_trip_counts_and_weather;
DROP TABLE fhv_bases;
DROP TABLE fhv_tripdata;
DROP TABLE fhvhv_tripdata;
DROP TABLE green_tripdata;
DROP TABLE yellow_tripdata;

-- loading data from the data folder in the local machine
-- glob syntax was used to match file name patterns
-- for CSV files, all data were imported as VARCHAR to preserve information at the ingestion step
CREATE TABLE bike_data AS SELECT * FROM read_csv_auto(['/Users/shaopengzhang/Downloads/data/bike/*.csv.gz'], union_by_name=True, all_varchar=True, filename=True);

CREATE TABLE central_park_weather AS SELECT * FROM read_csv_auto(['/Users/shaopengzhang/Downloads/data/central_park_weather.csv'], union_by_name=True, all_varchar=True, filename=True);

CREATE TABLE daily_citi_bike_trip_counts_and_weather AS SELECT * FROM read_csv_auto(['/Users/shaopengzhang/Downloads/data/daily_citi_bike_trip_counts_and_weather.csv'], union_by_name=True, all_varchar=True, filename=True);

CREATE TABLE fhv_bases AS SELECT * FROM read_csv_auto(['/Users/shaopengzhang/Downloads/data/fhv_bases.csv'], union_by_name=True, all_varchar=True, filename=True);

CREATE TABLE fhv_tripdata AS SELECT * FROM read_parquet('/Users/shaopengzhang/Downloads/data/taxi/fhv_tripdata_*.parquet', union_by_name=True, filename=True);

CREATE TABLE fhvhv_tripdata AS SELECT * FROM read_parquet('/Users/shaopengzhang/Downloads/data/taxi/fhvhv_tripdata_*.parquet', union_by_name=True, filename=True);

CREATE TABLE green_tripdata AS SELECT * FROM read_parquet('/Users/shaopengzhang/Downloads/data/taxi/green_tripdata_*.parquet', union_by_name=True, filename=True);

CREATE TABLE yellow_tripdata AS SELECT * FROM read_parquet('/Users/shaopengzhang/Downloads/data/taxi/yellow_tripdata_*.parquet', union_by_name=True, filename=True);

