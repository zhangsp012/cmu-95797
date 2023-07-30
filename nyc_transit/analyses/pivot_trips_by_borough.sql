
-- query to pivot the results by borough
SELECT
  {{ dbt_utils.pivot(
      'borough',
      dbt_utils.get_column_values(ref('mart__fact_trips_by_borough'), 'borough'),
      agg = 'sum',
      then_value='trip_count'
  ) }}
FROM {{ ref('mart__fact_trips_by_borough') }}