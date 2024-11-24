/*Generate a report that calculates the total new passengers for each city and ranks them based on this value. 
Identify the top 3 cities with the highest number of new passengers as well as the bottom 3 cities with the 
lowest number of new passengers, categorizing them as 'Top 3' or 'Bottom 3' accordingly.*/

(select city_name , sum(new_passengers) as total_new_passangers ,
case 
when sum(new_passengers)>= (select sum(new_passengers) from fact_passenger_summary group by city_id order by 1 desc limit 1 offset 2 )  then "Top 3"
else 0
end as city_category
 from fact_passenger_summary
 join dim_city
 on fact_passenger_summary.city_id = dim_city.city_id
 group by 1
 order by 2 desc
 limit 3)

union 

(select city_name , sum(new_passengers) as total_new_passangers ,
case 
when sum(new_passengers)<= (select sum(new_passengers) from fact_passenger_summary group by city_id order by 1 asc limit 1 offset 2 )  then "Bottom 3"
else 0
end as city_category
 from fact_passenger_summary
 join dim_city
 on fact_passenger_summary.city_id = dim_city.city_id
 group by 1
 order by 2 asc
 limit 3);
