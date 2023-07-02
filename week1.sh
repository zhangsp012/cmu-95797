#!/bin/bash
set -x

# Ingest all the data
duckdb main.db -s ".read ./sql/ingest.sql"

# run the python script to get raw counts
python ./scripts/dump_raw_counts.py > ./answers/raw_counts.txt

# run the sql script to get the schemas
duckdb main.db -s ".read ./sql/dump_raw_schemas.sql" > ./answers/raw_schemas.txt