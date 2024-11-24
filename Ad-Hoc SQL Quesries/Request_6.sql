/*"Generate a report that calculates two metrics:
Monthly Repeat Passenger Rate: Calculate the repeat passenger rate for each city and 
month by comparing the number of repeat passengers to the total passengers.
City-wide Repeat Passenger Rate: Calculate the overall repeat passenger rate for each city, 
considering all passengers across months.
These metrics will provide insights into monthly repeat trends as well as the overall repeat behavior for each city.*/

with t1 as 
(select city_name,
city_id, 
month(month) as mnth , 
monthname(month) as months ,
sum(total_passengers) as total_passengers , 
sum(repeat_passengers) as repeat_passengers
from fact_passenger_summary
join dim_city
using (city_id)
group by 1,2,3,4
order by 1 asc , 3 asc )

select t1.city_name , 

t1.months, 
t1.total_passengers , 
t1.repeat_passengers , 
concat(round(t1.repeat_passengers/(t1.total_passengers) *100,2),"%") as monthly_repeat_passenger_rate,
concat(round(t1.repeat_passengers/(sum(t1.total_passengers) )*100,2),"%") as city_repeat_passenger_rate
from t1
join fact_passenger_summary
on t1.city_id = fact_passenger_summary.city_id
group by 1 , 2, 3, 4 , t1.mnth
order by 1 asc , t1.mnth;
