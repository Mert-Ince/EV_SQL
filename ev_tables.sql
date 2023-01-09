create table charging_points (
Region varchar(60),
Year int,
Value int );

create table ev_stocks(
region varchar(60),
vehicle varchar(15),
type varchar(15),
year int,
value int
);

create table ev_sales_share(
region varchar(60),
vehicle varchar(15),
category varchar(15),
year int,
value_percent double
);

create table renewables (
region varchar(60),
value_percent double
);

create table price_comparison(
date date,
avg_ev_price double,
avg_car_price double
);

create table ev_sales_share_future(
region varchar(60),
vehicle varchar(15),
category varchar(15),
year int,
value_percent double);

create table ev_stock_share(
region varchar(60),
vehicle varchar(15),
category varchar(15),
year int,
value_percent double);

create table gdp_per_capita(
region varchar(60),
value double);

create table maintaining_costs(
price varchar(15),
category varchar(15),
1_mile double,
1_year_average double);

create table oil_prices(
year int,
unit varchar(15),
price double);

create table sector_co2_emissions(
region varchar(60),
sector varchar(30),
gas varchar(15),
unit varchar(15),
value double,
percentage double);

select * from sector_co2_emissions;
drop table sector_co2_emissions;

create table sector_co2_emissions(
region varchar(60),
sector varchar(30),
gas varchar(15),
unit varchar(15),
value float);
drop table sector_co2_emissions;
select * from maintaining_costs;