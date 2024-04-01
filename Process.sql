-- Counting all the rows 
SELECT
  COUNT(*)
FROM `impactful-web-381604.cyclistic_data.biketrip_merged` LIMIT 1000

-- Checking for null values
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

-- Create a new table with no nulls
CREATE TABLE `impactful-web-381604.cyclistic_data.biketrip_merged_nonulls` AS
SELECT * 
FROM `impactful-web-381604.cyclistic_data.biketrip_merged`
WHERE 
  start_station_name IS NOT NULL AND
  end_station_name IS NOT NULL AND
  end_station_id IS NOT NULL AND
  end_lng IS NOT NULL AND
  start_station_id IS NOT NULL;
  
  -- Creating new tables: day_of_week,month, day, year, ride_length_m, and time
  SELECT
  ride_id,rideable_type,start_station_name, end_station_name, start_lat, start_lng,end_lat, end_lng, member_casual AS member_type,started_at,
  CASE 
    WHEN EXTRACT (DAYOFWEEK FROM started_at) = 1 THEN 'SUN'
    WHEN EXTRACT (DAYOFWEEK FROM started_at) = 2 THEN 'MON'
    WHEN EXTRACT (DAYOFWEEK FROM started_at) = 3 THEN 'TUE'
    WHEN EXTRACT (DAYOFWEEK FROM started_at) = 4 THEN 'WED'
    WHEN EXTRACT (DAYOFWEEK FROM started_at) = 5 THEN 'THU'
    WHEN EXTRACT (DAYOFWEEK FROM started_at) = 6 THEN 'FRI'
  ELSE 'SAT'
  END AS day_of_week,

  CASE
    WHEN EXTRACT (MONTH FROM started_at) = 1 THEN 'JAN'
    WHEN EXTRACT (MONTH FROM started_at) = 2 THEN 'FEB'
    WHEN EXTRACT (MONTH FROM started_at) = 3 THEN 'MAR'
    WHEN EXTRACT (MONTH FROM started_at) = 4 THEN 'APR'
  ELSE 'UNKOWN'
  END AS month,
  EXTRACT (DAY FROM started_at) AS day,
  EXTRACT (YEAR FROM started_at) AS year,
  TIMESTAMP_DIFF (ended_at, started_at, minute) AS ride_length_m,
  FORMAT_TIMESTAMP("%I:%M %p", started_at) AS time


FROM `impactful-web-381604.cyclistic_data.biketrip_merged_nonulls`

WHERE TIMESTAMP_DIFF (ended_at, started_at, minute) > 1 AND TIMESTAMP_DIFF (ended_at, started_at, hour) < 24