/*Generate a report that displays the total trips, average fare per km, average fare per trip, and 
the percentage contribution of each city's trips to the overall trips. This report will help in assessing trip volume, pricing efficiency, and each city’s contribution to the overall trip count*/


select city_name,
count(trip_id) as total_trips,
round(sum(fare_amount)/sum(distance_travelled_km),2) as avg_fare_per_km,
round(sum(fare_amount)/count(trip_id),2) as avg_fare_per_trip, 
concat(round(count(trip_id)/(select count(trip_id) from fact_trips)*100,2),"%") as contribution_pct_to_total_trips
from fact_trips
join dim_city
using (city_id)
group by city_name
order by 5 desc ;
