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

First, I verified the row count of the merged table, which totals 5,719,877 rows.
I also checked for duplicates using ride_id (which I determined to be the primary key). It returned 5,719,877 rows, which means there are no duplicates.

I also checked for any null values, which I found in:

* start_station_name_count, -- 875716 null values

* start_station_id_count, -- 875848 null values

* end_station_name_count, -- 929202 null values

* end_station_id_count, -- 929343 null values

* end_lat_count, -- 6990 null values

* end_lng_count, -- 6990 null values

Next, I created a new table called 'biketrip_merged_nonulls' by eliminating rows with null values. This step ensures a cleaner dataset for subsequent analysis.

After creating a table with no null values, I added new tables to make analysis easier.

* day_of_week: This column is created using a CASE statement that extracts the day of the week (e.g., 'SUN', 'MON', etc.) from the started_at timestamp.

* month: This column is created using a CASE statement that extracts the month (e.g., 'JAN', 'FEB', etc.) from the started_at timestamp.

* day, year: These columns are created by directly extracting the day and year from the started_at timestamp using the EXTRACT function.

* ride_length_m: This column calculates the length of the ride in minutes by taking the difference between the ended_at and started_at timestamps, using the TIMESTAMP_DIFF function.

* time: This column formats the started_at timestamp to display the time in the format "HH:MM AM/PM", using the FORMAT_TIMESTAMP function.

## ANALYZE

### How do annual members and casual riders use Cyclistic bikes differently?

I looked at the average, max, and min of ride_length_m.

* avg_ride_length 15.993585462396611
* max_ride_length 1439
* min_ride_length 2

The maximum ride length returned 1439 minutes, which suggests that there is a ride in the dataset that lasted for nearly an entire day. One possibility is a data entry error, where incorrect start or end times were recorded for a ride. Additionally, system glitches or malfunctions may have led to inaccuracies in the recorded ride durations. Alternatively, it's conceivable that a user intentionally kept a bike checked out for an extended period, possibly due to forgetfulness or other reasons. 

#### Casual vs. Members : ride length
Now, let's look at how casual and member riders' ride length differ from each other:

* For "casual" riders, the longest ride lasted 1437 minutes, the shortest was 2 minutes, with an average ride duration of approximately 22.97 minutes.

* "Member" riders had a maximum ride length of 1439 minutes, a minimum of 2 minutes, and an average ride duration of around 12.12 minutes.

#### Bike Ride Usage Throughout the Week (Monday to Sunday)

<img width="326" alt="image" src="https://github.com/jessapoy/Cyclistic/assets/144876455/49dd0d5b-c6b0-4929-82aa-ae75efc29422">

Pulling the most bike ride usage throughout the week, members and casual riders combined, Saturday places first with 639,975 rides, and Monday with 540,333 rides.

<img width="468" alt="image" src="https://github.com/jessapoy/Cyclistic/assets/144876455/ecf7b429-a5d2-47e0-b186-2926afd9cdc6">

Wednesday - Members: With 433,919 rides, Wednesday is the busiest day for members, indicating heightened activity midweek.

Thursday - Members: Following closely, Thursday sees 432,879 rides among members, maintaining the trend of weekday activity.

Saturday - Casual Riders: Casual riders prefer Saturdays, with 301,170 rides recorded, likely due to weekend leisure.

Sunday - Casual Riders: Sundays also show significant activity among casual riders, with 247,346 rides, suggesting weekend popularity for casual riding.

#### Bike Ride Usage: By Member Type and Month

![image](https://github.com/jessapoy/Cyclistic/assets/144876455/4d0a77da-69b4-4ac0-8cc4-ec4a4cc6ac74)

The month of July has the highest ride count (238,190 rides) for casual riders, while August emerged as the busiest month for member riders, with 337,985 rides, likely due to favorable weather conditions during the summer season.

The months December, January, and February have the least rides for both casual and member riders, possibly due to winter weather conditions impacting outdoor activities.

#### Start Stations

![image](https://github.com/jessapoy/Cyclistic/assets/144876455/7f39d2fc-6e04-4f7a-a747-b27a8097de07)

Overall, the total bike rides start at Streeter Dr & Grand Ave, which is located by the tourist attraction Navy Pier. The location gets easily congested and does not have a lot of entryways and exit for cars, which can explain why there are a lot of people who use bikes as their mode of transportation.

![image](https://github.com/jessapoy/Cyclistic/assets/144876455/e8ad62ca-fbd9-40ec-bf07-42d4a55f009c)

For members, Kingsbury St & Kinzie St tops the list with 23,408 total rides.

![image](https://github.com/jessapoy/Cyclistic/assets/144876455/7814923f-6956-4d25-8f09-e8cfa0eb209c)

Like the overall top start bike location, casual riders favored Streeter Dr & Grand Ave with 42,042 rides.

The discrepancy in preferred bike stations between casual riders and regular members reveals distinct user behaviors and priorities. Casual riders, often tourists exploring Chicago's attractions, gravitate towards stations clustered around iconic landmarks like Navy Pier and Millennium Park. These locations offer convenient access for sightseeing and leisurely exploration of the city's highlights.

In contrast, regular members prioritize stations strategically situated near residential areas, workplaces, and transportation hubs. These stations, such as Kingsbury St & Kinzie St and Clinton St & Washington Blvd, serve the practical needs of daily commuters and residents running errands. This divergence underscores the nuanced preferences between tourist and local user groups, highlighting the versatility of bike-sharing services in catering to diverse usage patterns in urban environments like Chicago.

## SHARE

### Why would casual riders buy Cyclistic annual memberships?

Despite the apparent focus of casual riders on tourist-centric locations, there are compelling reasons for them to consider purchasing annual memberships for bike-sharing services.

* Cost Savings: While casual riders may initially opt for single-ride or day passes for occasional use, the cumulative cost of these individual rides can quickly add up, surpassing the cost of an annual membership. By investing in an annual membership, casual riders can enjoy unlimited rides throughout the year at a fraction of the cost per ride.

* Avoiding Queues and Waiting Times: With an annual membership, casual riders can bypass queues and waiting times at bike stations, particularly during peak tourist seasons or busy hours. This time-saving benefit ensures quick and hassle-free access to bikes whenever they need them, enhancing the overall efficiency of their travel experience.

* Encouraging Regular Exercise and Health Benefits: Beyond sightseeing, biking offers numerous health benefits, including cardiovascular exercise, stress reduction, and improved mental well-being. By investing in an annual membership, casual riders can integrate regular biking into their lifestyle, promoting a more active and healthy way of exploring the city during their stay.

## ACT

### How can Cyclistic use digital media to influence casual riders to become members?

**Discounts or Freebies for Ride Milestones:**
Cyclistic can incentivize casual riders to become members by offering discounts or freebies when they reach a certain number of rides. For example, after completing a specified number of rides within a given time frame, such as 10 rides in a month, riders could unlock discounts on their next membership renewal or receive complimentary bike accessories. This approach not only encourages riders to use the service more frequently but also rewards their loyalty and encourages them to commit to a membership for continued benefits.

**Promotion of Health Benefits:**
Highlighting the health benefits of biking through digital media can resonate with casual riders and motivate them to consider becoming members. Cyclistic can emphasize how regular biking promotes physical fitness, cardiovascular health, and stress reduction. Additionally, showcasing testimonials or success stories from members who have experienced positive health outcomes from biking can provide social proof and inspire casual riders to prioritize their well-being by incorporating biking into their routine through membership.

**Advantages of Biking During Peak or Rush Hours:**
Cyclistic can educate casual riders about the benefits of using bikes during peak or rush hours, particularly in urban areas like Chicago where traffic congestion is common. Digital media campaigns can emphasize how biking offers a faster and more efficient alternative to traditional modes of transportation during busy times, allowing riders to bypass traffic jams and arrive at their destinations more quickly. Highlighting the time-saving aspect of biking during peak hours can appeal to casual riders looking for convenient and stress-free commuting options, ultimately encouraging them to become members to enjoy these benefits regularly.
