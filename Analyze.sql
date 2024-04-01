WITH rides AS (
  SELECT
    ride_id, rideable_type, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng,
    member_casual AS member_type,
    started_at,
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
      WHEN EXTRACT (MONTH FROM started_at) = 5 THEN 'MAY'
      WHEN EXTRACT (MONTH FROM started_at) = 6 THEN 'JUN'
      WHEN EXTRACT (MONTH FROM started_at) = 7 THEN 'JUL'
      WHEN EXTRACT (MONTH FROM started_at) = 8 THEN 'AUG'
      WHEN EXTRACT (MONTH FROM started_at) = 9 THEN 'SEP'
      WHEN EXTRACT (MONTH FROM started_at) = 10 THEN 'OCT'
      WHEN EXTRACT (MONTH FROM started_at) = 11 THEN 'NOV'
      WHEN EXTRACT (MONTH FROM started_at) = 12 THEN 'DEC'
    ELSE 'UNKNOWN'
    END AS month,
    EXTRACT (DAY FROM started_at) AS day,
    EXTRACT (YEAR FROM started_at) AS year,
    TIMESTAMP_DIFF(ended_at, started_at, minute) AS ride_length_m,
    FORMAT_TIMESTAMP("%I:%M %p", started_at) AS time
  FROM `impactful-web-381604.cyclistic_data.biketrip_merged_nonulls`
  WHERE TIMESTAMP_DIFF(ended_at, started_at, minute) > 1 
    AND TIMESTAMP_DIFF(ended_at, started_at, hour) < 24
)

--Looking at max, min, and avg of ride_length_m

SELECT
  AVG(ride_length_m) AS avg_ride_length,
  MAX(ride_length_m) AS max_ride_length,
  MIN(ride_length_m) AS min_ride_length
FROM (
  SELECT
    TIMESTAMP_DIFF(ended_at, started_at, minute) AS ride_length_m
  FROM `impactful-web-381604.cyclistic_data.biketrip_merged_nonulls`
  WHERE TIMESTAMP_DIFF(ended_at, started_at, minute) > 1
    AND TIMESTAMP_DIFF(ended_at, started_at, hour) < 24
);

-- Ride length by member type. Casual vs. Member

SELECT
    member_type,
    MAX(ride_length_m) AS max_ride_length,
    MIN(ride_length_m) AS min_ride_length,
    AVG(ride_length_m) AS avg_ride_length
FROM 
    rides
GROUP BY
    member_type;
    
-- When the bike ride is mostly being used throughout the week (Monday — Sunday)

SELECT
  day_of_week,
  COUNT(*) AS ride_count
FROM 
  rides
GROUP BY
  day_of_week
ORDER BY
  ride_count DESC;
  
-- by members and casual riders mon -sun

SELECT
  member_type,
  day_of_week,
  COUNT(*) AS ride_count
FROM 
  rides
GROUP BY
  member_type,
  day_of_week
ORDER BY
  member_type,
  ride_count DESC;
  
-- Most rides by month (members vs. casual)

SELECT
  member_type,
  month,
  COUNT(*) AS ride_count
FROM 
  rides
GROUP BY
  member_type,
  month
ORDER BY
  member_type,
  ride_count DESC;
  
-- Most rides by start_stations

SELECT
    start_station_name,
    COUNT(*) AS total,
    SUM(CASE WHEN member_type = 'member' THEN 1 ELSE 0 END) AS member,
    SUM(CASE WHEN member_type = 'casual' THEN 1 ELSE 0 END) AS casual
FROM 
    rides
GROUP BY 
    start_station_name
ORDER BY 
    total DESC;