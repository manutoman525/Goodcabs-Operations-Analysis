/*Generate a report that evaluates the target performance for trips at the monthly and city level. For each city and month, compare the actual total trips with the target trips and categorize the performance as follows:
If actual trips are greater than target trips, mark it as 'Above Target'.
If actual trips are less than or equal to target trips, mark it as 'Below Target'.
Additionally, calculate the % difference between actual and target trips to quantify the performance gap.*/

with t1 as (
select trips_db.fact_trips.city_id as city , 
trips_db.dim_city.city_name as city_name ,
month(trips_db.fact_trips.date) as dt, 
monthname(trips_db.fact_trips.date) as month_name,
count(trips_db.fact_trips.trip_id) as cnt 
from trips_db.dim_city
join trips_db.fact_trips
on trips_db.dim_city.city_id = trips_db.fact_trips.city_id
join targets_db.monthly_target_trips
on trips_db.fact_trips.city_id = targets_db.monthly_target_trips.city_id
and month(trips_db.fact_trips.date) = month(targets_db.monthly_target_trips.month)
group by 1,2,3 , 4)

select  t1.city_name ,
t1.month_name ,
t1.cnt as actual_trips , 
sum(targets_db.monthly_target_trips.total_target_trips) as target_trips,
case 
when t1.cnt >= sum(targets_db.monthly_target_trips.total_target_trips) then "Above Target"
else "Below Target"
end as performance_status,
concat(round((t1.cnt-sum(targets_db.monthly_target_trips.total_target_trips))/(sum(targets_db.monthly_target_trips.total_target_trips))*100,2),"%") as difference_pct
from targets_db.monthly_target_trips
join t1
on targets_db.monthly_target_trips.city_id = t1.city  and  month(targets_db.monthly_target_trips.month) = t1.dt
group by  t1.city , t1.dt , t1.month_name
order by 1 asc ,t1.dt asc;