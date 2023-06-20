create database udaan;
use udaan;

create table business_city (
business_date date,
city_id int
);

insert into business_city
values(cast('2020-01-02' as date),3),
(cast('2020-07-01' as date),7),
(cast('2021-01-01' as date),3),
(cast('2021-02-03' as date),19)
,(cast('2022-12-01' as date),3),
(cast('2022-12-15' as date),3),
(cast('2022-02-28' as date),12);

select * from business_city;


-- write a query to identify yearwise count of new city where udaan started  their operation
-- 1.Method
Delimiter 
create procedure new_cities()
begin
     with cte as 
(select year(business_date) as year,city_id,
row_number() over (partition by city_id ) as rn 
 from business_city)
 select year, count(city_id) as new_city from cte
 where rn =1
 group by year;
 end;
  
 
 -- 2.Method 
 with cte as (select city_id, min(year(business_date))as year from business_city
 group by 1)
 select year, count(city_id) as new_cities from cte
 group by 1;
 
 
 -- 3.Method
 with cte as (select city_id ,(year(business_date)) as business
from business_city)
select  c.business,
count(case when c2.city_id is null then c.city_id end ) as new_cities
from cte c left join cte c2
 on c.business>c2.business and c.city_id=c2.city_id
 group by 1