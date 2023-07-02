# cmu-95797-23m6

## Week 1
### Objectives
- Install and setup
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