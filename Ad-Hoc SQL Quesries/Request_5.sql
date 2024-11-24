/*Generate a report that identifies the month with the highest revenue for each city. 
For each city, display the month_name, the revenue amount for that month, and the percentage contribution of 
that month’s revenue to the city’s total revenue.*/

with t1 as (select city_name , fact_trips.city_id as city_id,  monthname(date) as months  , sum(fare_amount) as revenue  , 
rank()  over (partition by city_name  order by sum(fare_amount) desc ) as a
 from fact_trips
 join dim_city
 on fact_trips.city_id = dim_city.city_id
 group by 1 , 2 , 3
 order by 4 desc)
 
 
 select t1.city_name ,t1.months as highest_revenue_month , revenue  ,concat(round(revenue/ sum(fare_amount)*100,2),"%") as contribution_pct 
 from t1
 join fact_trips
 on t1.city_id = fact_trips.city_id
 where a = 1
 group by 1 , 2,3
 order by 4 desc;
