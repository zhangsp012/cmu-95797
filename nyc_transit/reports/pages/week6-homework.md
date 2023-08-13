Show a query which counts all trips by type

```trips_by_type
select
  type,
  count(*) trips
from mart.mart__fact_all_trips
group by 1 order by 1 desc
```
Now format the query output as a table to show to show trips in 3SF comma separated

<DataTable data="{trips_by_type}">
    <Column id="type" title="Transit Type" />
    <Column id="trips" fmt='#,##0' />
</DataTable>

Now show the query output as a bar chart

<BarChart 
    data={trips_by_type} 
    x=type
    y=trips 
    xAxisTitle="Transit Type"
    yAxisTitle="Trips"
/>

Show the trips as a stacked bar chart by year split by type

```trips_by_type_year
select
  type,
  year(started_at_ts) as year,
  count(*) trips
from mart.mart__fact_all_trips
where year in (2020,2021)
group by all
```

<BarChart 
    data={trips_by_type_year} 
    x=year
    y=trips
    series=type 
    xAxisTitle="Year"
    yAxisTitle="Trips"
/>

Run the first query from the second query

```trips_by_type2
select
  type,
  sum(trips) trips
from ${trips_by_type_year}
group by all
```

Explain why this is good?

Answer: It reduces the number of queries to hit your data warehouse, the second query runs off the cache of the first

Plot the percentage of trips which are bike trips by day as a line graph

```bike_trips_perc
select
  date_trunc('day', started_at_ts) as date,
  sum(case when type = 'bike' then 1 else 0 end)/count(*) as bike_trips_percentage
from mart.mart__fact_all_trips
where year(started_at_ts) in (2020,2021)
group by all
```

<LineChart 
    data={bike_trips_perc}  
    x=date 
    y=bike_trips_percentage
    xAxisTitle="Date"
    yAxisTitle="Bike Trips %"
    yFmt=pct
/>

Plot precipitation and snow as an area chart

```precip_snow
select
  date,
  prcp as rain,
  snow as snow
from staging.stg_main__central_park_weather
where year(date) in (2020, 2021)
```

```precip_snow_max
select
  max(prcp) as rain,
  max(snow) as snow
from staging.stg_main__central_park_weather
where year(date) in (2020, 2021)
```

Normalise Snow and Rain as Evidence doesn't have secondary axes

```precip_snow_norm
select
  date,
  prcp/5 as rain,
  snow/15 as snow
from staging.stg_main__central_park_weather
where year(date) in (2020, 2021)
```

<AreaChart 
    data={precip_snow}  
    x=date 
    y={['rain','snow']}
/>

Now plot both the bike trip perc and the weather data together

```weather_bike
select
    w.date,
    w.rain,
    w.snow,
    b.bike_trips_percentage
from ${precip_snow_norm} as w
join ${bike_trips_perc} as b on w.date = b.date
```

<Chart data={weather_bike}>
    <Line
        y=bike_trips_percentage
        yAxisTitle="Bike Trips %"
        yFmt=pct
        yMax=0.3
    />
    <Area
        y={['rain','snow']}
    />
</Chart>

Let's try a scatter plot of precip_snow vs bike_trip_perc

```weather_bike2
select
    w.date,
    greatest(w.rain, w.snow) precip_snow,
    b.bike_trips_percentage
from ${precip_snow_norm} as w
join ${bike_trips_perc} as b on w.date = b.date
```

<ScatterPlot 
    data={weather_bike2} 
    y=bike_trips_percentage 
    x=precip_snow 
    yAxisTitle="Bike Trips %" 
    xAxisTitle="Greatest of Norm Rain/Snow"
    yFmt=pct
    pointSize=2
    yMin=0
    xMin=0
/>

Let's try plotting fare against distance.

Address the issue with size of the data.

```fare_sample
SELECT 
  trip_miles,
  trip_time,
  base_passenger_fare
FROM staging.stg_main__fhvhv_tripdata
USING SAMPLE 0.001%
```

<ScatterPlot 
    data={fare_sample} 
    y=base_passenger_fare 
    x=trip_miles 
    yAxisTitle="Fare $" 
    xAxisTitle="Trip Miles"
    yFmt=usd
    pointSize=2
    yMin=0
    xMin=0
/>

Let's try plotting fare against time.

<ScatterPlot 
    data={fare_sample} 
    y=base_passenger_fare 
    x=trip_time
    yAxisTitle="Fare $" 
    xAxisTitle="Trip Time"
    yFmt=usd
    pointSize=2
    yMin=0
    xMin=0
/>

It looks like the correlation is stronger between fare and distance than fare and trip time.
As we are using the FHVHV data it is likely that this is because the fare is calculated from the distance
by Uber/Lyft

Is this true for Yellow Taxis?

Let's try plotting fare against distance.

Address the issue with size of the data, acknowledging how much less yellow data there is.

```fare_sample_yellow
SELECT 
  trip_distance,
  datediff('min', tpep_pickup_datetime, tpep_dropoff_datetime) as trip_time,
  fare_amount
FROM staging.stg_main__yellow_tripdata
USING SAMPLE 0.01%
```

<ScatterPlot 
    data={fare_sample_yellow} 
    y=fare_amount 
    x=trip_distance 
    yAxisTitle="Fare $" 
    xAxisTitle="Trip Miles"
    yFmt=usd
    pointSize=2
    yMin=0
    xMin=0
/>

Let's try plotting fare against time.

<ScatterPlot 
    data={fare_sample_yellow} 
    y=fare_amount 
    x=trip_time
    yAxisTitle="Fare $" 
    xAxisTitle="Trip Time"
    yFmt=usd
    pointSize=2
    yMin=0
    xMin=0
/>