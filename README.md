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

I am merging the 12 datasets into one table to make querying easier.

CREATE TABLE `impactful-web-381604.cyclistic_data.biketrip_merged` AS (
 SELECT *
  FROM ( 
  SELECT * 
  FROM `impactful-web-381604.cyclistic_data.01_2023` 
  UNION ALL
  SELECT * 
  FROM `impactful-web-381604.cyclistic_data.02_2023` 
  UNION ALL
  SELECT * 
  FROM `impactful-web-381604.cyclistic_data.03_2023` 
  UNION ALL
  SELECT * 
  FROM `impactful-web-381604.cyclistic_data.04_2023` 
  UNION ALL
  SELECT * 
  FROM `impactful-web-381604.cyclistic_data.05_2023` 
  UNION ALL
  SELECT * 
  FROM `impactful-web-381604.cyclistic_data.06_2023` 
  UNION ALL
  SELECT * 
  FROM `impactful-web-381604.cyclistic_data.07_2023` 
  UNION ALL
  SELECT * 
  FROM `impactful-web-381604.cyclistic_data.08_2023` 
  UNION ALL
  SELECT * 
  FROM `impactful-web-381604.cyclistic_data.09_2023` 
  UNION ALL
  SELECT * 
  FROM `impactful-web-381604.cyclistic_data.10_2023` 
  UNION ALL
  SELECT * 
  FROM `impactful-web-381604.cyclistic_data.11_2023` 
  UNION ALL
  SELECT * 
  FROM `impactful-web-381604.cyclistic_data.12_2023`
))


## PROCESS
 
Here I am counting the rows of the new table

SELECT
  COUNT(*)
FROM `impactful-web-381604.cyclistic_data.biketrip_merged` LIMIT 1000

The table has 5,719,877 rows.

I also checked for duplicates using ride_id (which I determined to be the primary key).

SELECT count(distinct (ride_id)) 
FROM`impactful-web-381604.cyclistic_data.biketrip_merged`

It returned 5,719,877 rows, which means there are no duplicates.

Checking for null values:

SELECT 
  COUNT(*) - COUNT(ride_id) AS ride_id_count,
  COUNT(*) - COUNT(rideable_type) AS rideable_type_count,
  COUNT(*) - COUNT(started_at) AS started_at_count,
  COUNT(*) - COUNT(ended_at) AS ended_at_count,
  COUNT(*) - COUNT(start_station_name) AS start_station_name_count, -- 875716 null values
  COUNT(*) - COUNT(start_station_id) AS start_station_id_count, -- 875848 null values
  COUNT(*) - COUNT(end_station_name) AS end_station_name_count, -- 929202 null values
  COUNT(*) - COUNT(end_station_id) AS end_station_id_count, -- 929343 null values
  COUNT(*) - COUNT(start_lat) AS start_lat_count,
  COUNT(*) - COUNT(start_lng) AS start_lng_count,
  COUNT(*) - COUNT(end_lat) AS end_lat_count, -- 6990 null values
  COUNT(*) - COUNT(end_lng) AS end_lng_count, -- 6990 null values
  COUNT(*) - COUNT(member_casual) AS member_casual_count,

FROM
`impactful-web-381604.cyclistic_data.biketrip_merged`

## ANALYZE
