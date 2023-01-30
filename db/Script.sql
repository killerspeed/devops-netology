
-- 6
select lower  (last_name) AS last_name, lower (first_name) as first_name, active 
from customer 
where (first_name ='KELLY' or first_name ='WILLIE')  and active =1;

-- 5
select concat (last_name, ' ',first_name) as "Фамиля и Имя", email,
CHARACTER_LENGTH (email) as "Длина Email", 
date (last_update) as Дата
FROM customer;

-- 4
select payment_id, payment_date, amount
from	payment
order by payment_date desc limit 10;

--3 
select payment_id, payment_date, amount 
from payment
where payment_date>='2005-06-17' and payment_date<='2005-06-20' and amount >1
order by payment_date;
--2 
select  city 
from city
where city ilike 'l%a' and city  not like '% %'
order by city ; 
--1
select distinct city from city;
