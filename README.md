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