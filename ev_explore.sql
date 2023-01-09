/* Which countries has the most electric cars, how was it in the past and how is it going be in the future? */
-- Countries with the most electric cars
select region, sum(value) as total_stocks 
from ev_stocks 
where year = "2021" 
group by region 
order by value desc;

-- Past and future market EV market share of the todays biggest EV markets
create temporary table past_today
select region, 
sum(case when year = "2013" then value_percent else 0 end) as year_2013,
sum(case when year = "2017" then value_percent else 0 end) as year_2017,
sum(case when year = "2021" then value_percent else 0 end) as year_2021
from ev_sales_share where vehicle = "Cars" group by region; 

create temporary table future
select region,
sum(case when year = "2025" then value_percent else 0 end) as year_2025,
sum(case when year = "2030" then value_percent else 0 end) as year_2030 
from ev_sales_share_future where vehicle = "Cars" group by region; 

select past_today.region, past_today.year_2013, past_today.year_2017, past_today.year_2021, future.year_2025, future.year_2030 from past_today inner join future on past_today.region = future.region group by past_today.region order by past_today.year_2021 desc;

/* Are biggest EV car markets are the biggest market for electric busses, vans and trucks as well? */
select region, 
sum(case when vehicle = "Cars" then value_percent else 0 end) as ev_cars_share,
sum(case when vehicle = "Vans" then value_percent else 0 end) as ev_vans_share,
sum(case when vehicle = "Trucks" then value_percent else 0 end) as ev_trucks_share,
sum(case when vehicle = "Buses" then value_percent else 0 end) as ev_buses_share
from ev_sales_share where year = "2021" group by region order by ev_cars_share desc;

/* Which countries ev car sales increased the most since last year? */
create temporary table 2020_and_2021
select region,
sum(case when year = "2020" then value_percent else 0 end) as year_2020,
sum(case when year = "2021" then value_percent else 0 end) as year_2021 
from ev_sales_share where vehicle = "Cars" group by region;
select *, (year_2021 - year_2020) as growth, ((year_2021/year_2020)*100)-100 as percent_growth from 2020_and_2021 order by percent_growth desc;

/* Is there any correlation between electric car ownership and how many charging points a country has or population wealth? */
-- charging points and car stock of 2021
create temporary table bev_phev_sum 
select region, sum(value) as total_evs 
from ev_stocks 
where year = "2021" 
group by region; 

select bev_phev_sum.region, bev_phev_sum.total_evs, sum(charging_points.value) as chargers, (sum(charging_points.value)/bev_phev_sum.total_evs) as charger_per_ev 
from bev_phev_sum inner 
join charging_points on bev_phev_sum.region = charging_points.region 
where charging_points.year = "2021" 
group by region
order by 2 desc;
-- gdp per capita and EV market share of 2021
select ev_sales_share.region, ev_sales_share.value_percent, gdp_per_capita.value as gdpp_capita 
from ev_sales_share inner join gdp_per_capita on ev_sales_share.region = gdp_per_capita.region 
where ev_sales_share.vehicle = "Cars" and ev_sales_share.year = "2021" 
group by region 
order by ev_sales_share.value_percent desc;

/* In which countries the ev's would be most effective? */
 -- Finding the percentage of co2 the transportation sector is responsible of in every country
create temporary table transportation_percentage
select region, unit,
sum(case when sector = "Transportation" then value else 0 end) as transportation_co2,
sum(case when sector = "Total including LUCF" then value else 0 end) as total_co2
from co2_emissions group by region;

select *, ((transportation_co2/total_co2)*100) as percentage from transportation_percentage order by percentage desc;
-- Finding the countries who produce the cleanest electric
select * from renewables order by value_percent desc;