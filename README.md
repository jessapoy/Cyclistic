# Cyclistic

# How Does a Bike-Share Navigate Speedy Success?

### Scenario
I'm a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, the team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, the team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve my recommendations, so they must be backed up with compelling data insights and professional data visualizations.

### About Cyclistic
Cyclistic, launched in 2016, operates a bike-share program in Chicago with 5,824 bikes across 692 stations. The program allows bikes to be unlocked from one station and returned to any other. Previously, their marketing focused on broad consumer segments and flexible pricing plans. Casual riders purchase single-ride or full-day passes, while annual memberships are available for frequent users. Financial analysis shows that annual members are more profitable. To drive future growth, the company aims to convert casual riders into annual members. Moreno, the marketing lead, plans to analyze historical bike trip data to understand customer behavior and optimize marketing strategies.

## ASK
Three questions will guide the future marketing program:

1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

## PREPARE

I will be using data from [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html). The data has been made available by Motivate International Inc. under this [license](https://divvybikes.com/data-license-agreement). All personally identifiable information has been removed. The dataframe I will be working on consists of data from January 2023 through December 2023. Each file consists of 13 columns: ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual.

### Merging data

I am merging the 12 datasets into one [table](https://github.com/jessapoy/Cyclistic/blob/main/Merging%20data.sql) to make querying easier.

## PROCESS
 
You can find the code for cleaning process of the data [here](https://github.com/jessapoy/Cyclistic/blob/main/Process.sql).

First,I verified the row count of the merged table, which totals 5,719,877 rows.
I also checked for duplicates using ride_id (which I determined to be the primary key). It returned 5,719,877 rows, which means there are no duplicates.

I also checked for any null values, which I found in:

* start_station_name_count, -- 875716 null values

* start_station_id_count, -- 875848 null values

* end_station_name_count, -- 929202 null values

* end_station_id_count, -- 929343 null values

* end_lat_count, -- 6990 null values

* end_lng_count, -- 6990 null values

## ANALYZE
