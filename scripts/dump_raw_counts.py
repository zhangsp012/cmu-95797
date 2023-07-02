# This scripts is set to run by week1.sh under the cmu-95797 folder
# To run this in the current directory, change line 7 ./main.db to ../main.db
# import the duckdb module
import duckdb

# Connect to the duckdb database located at '../main.db', with read-only access
con = duckdb.connect('./main.db', read_only=True)

# List of tables for which we want to count the rows
tables = ["bike_data", "central_park_weather", "daily_citi_bike_trip_counts_and_weather", "fhv_bases", "fhv_tripdata", "fhvhv_tripdata", "green_tripdata", "yellow_tripdata"]

# Loop through each table in the tables list
for t in tables:
    con.execute(f"SELECT COUNT (*) FROM {t}")
    print(t, con.fetchall()[0][0])

# Close the connection to the database
con.close()


