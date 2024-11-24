/*Generate a report that shows the percentage distribution of repeat passengers by the number of trips  they have 
taken in each city. Calculate the percentage of repeat passengers who took 2 trips, 3 trips, and so on, up to 10 trips.
Each column should represent a trip count category, displaying the percentage of repeat passengers who fall into that 
category out of the total repeat passengers for that city.
This report will help identify cities with high repeat trip frequency, 
which can indicate strong customer loyalty or frequent usage patterns.
*/

with t1 as (select dim_repeat_trip_distribution.city_id as city_id, dim_city.city_name as city_name,
sum(case when dim_repeat_trip_distribution.trip_count = "2-Trips" then dim_repeat_trip_distribution.repeat_passenger_count else 0 end) as "2_Trips",
sum(case when dim_repeat_trip_distribution.trip_count = "3-Trips" then dim_repeat_trip_distribution.repeat_passenger_count else 0 end) as "3_Trips",
sum(case when dim_repeat_trip_distribution.trip_count = "4-Trips" then dim_repeat_trip_distribution.repeat_passenger_count else 0 end) as "4_Trips",
sum(case when dim_repeat_trip_distribution.trip_count = "5-Trips" then dim_repeat_trip_distribution.repeat_passenger_count else 0 end) as "5_Trips",
sum(case when dim_repeat_trip_distribution.trip_count = "6-Trips" then dim_repeat_trip_distribution.repeat_passenger_count else 0 end) as "6_Trips",
sum(case when dim_repeat_trip_distribution.trip_count = "7-Trips" then dim_repeat_trip_distribution.repeat_passenger_count else 0 end) as "7_Trips",
sum(case when dim_repeat_trip_distribution.trip_count = "8-Trips" then dim_repeat_trip_distribution.repeat_passenger_count else 0 end) as "8_Trips",
sum(case when dim_repeat_trip_distribution.trip_count = "9-Trips" then dim_repeat_trip_distribution.repeat_passenger_count else 0 end) as "9_Trips",
sum(case when dim_repeat_trip_distribution.trip_count = "10-Trips" then dim_repeat_trip_distribution.repeat_passenger_count else 0 end) as "10_Trips"
from dim_repeat_trip_distribution
join dim_city
on dim_city.city_id = dim_repeat_trip_distribution.city_id
group by 1,2)

select t1.city_name,
 concat(round(2_Trips/sum(dim_repeat_trip_distribution.repeat_passenger_count)*100,2),"%") as "2_trips", 
 concat(round(3_Trips/sum(dim_repeat_trip_distribution.repeat_passenger_count)*100,2),"%") as "3_trips",
 concat(round(4_Trips/sum(dim_repeat_trip_distribution.repeat_passenger_count)*100,2),"%") as "4_trips", 
 concat(round(5_Trips/sum(dim_repeat_trip_distribution.repeat_passenger_count)*100,2),"%") as "5_tripd", 
 concat(round(6_Trips/sum(dim_repeat_trip_distribution.repeat_passenger_count)*100,2),"%") as "6_trips",
 concat(round(7_Trips/sum(dim_repeat_trip_distribution.repeat_passenger_count)*100,2),"%") as "7_trips", 
 concat(round(8_Trips/sum(dim_repeat_trip_distribution.repeat_passenger_count)*100,2),"%") as "8_trips", 
 concat(round(9_Trips/sum(dim_repeat_trip_distribution.repeat_passenger_count)*100,2),"%") as "9_trips", 
 concat(round(10_Trips/sum(dim_repeat_trip_distribution.repeat_passenger_count)*100,2),"%") as "10_trips"
 from t1 
 join dim_repeat_trip_distribution
 on t1.city_id = dim_repeat_trip_distribution.city_id
 group by t1.city_id