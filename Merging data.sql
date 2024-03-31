-- Merging all the datasets into one table
CREATE TABLE `your_project_id.your_dataset_id.your_new_table_name` AS
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
 