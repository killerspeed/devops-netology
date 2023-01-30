
-- 1
select concat (last_name, ' ',first_name) as "Фамиля и Имя", a.address, c1.city, c2.country
from customer c  
left join  address a on a.address_id=c.address_id
left join city c1 on c1.city_id=a.city_id
left join country c2 on c2.country_id=c1.country_id;
-- 2
SELECT c.store_id as "id магазина", COUNT(c2.customer_id) as "Количество покупателей", c1.city as "Город", concat (s.last_name, ' ',s.first_name) as "Фамиля и Имя"
from customer c  
INNER JOIN customer c2 ON c2.customer_id=c.store_id
INNER join staff s on s.staff_id=c.store_id
inner join address a on a.address_id=s.address_id
inner join city c1 on c1.city_id=a.city_id
where c.store_id=1
group by c.store_id, s.first_name , s.last_name, c1.city;


-- 3
select concat(c.last_name, ' ', c.first_name ) ,
COUNT(rental_id) as "количество фильмов"
FROM rental r
join customer c on c.customer_id=r.customer_id 
GROUP BY c.customer_id
ORDER BY "количество фильмов" 
DESC LIMIT 5;
-- 4
select concat(c.last_name, ' ', c.first_name ) as name, 
COUNT(r.rental_id) as "количество фильмов",round(sum(amount)), min(amount),max(amount)
FROM customer c 
join payment p on p.customer_id=c.customer_id 
join  rental r on r.rental_id=p.payment_id 
group by c.last_name, c.first_name
LIMIT 5;
-- 5
select c1.city, c.city 
FROM city c1 cross join city c
where  c1.city<>c.city;
-- 6
 (select customer_id  as "id покупателя ",avg(return_date::date - rental_date::date)
 from rental
 group by customer_id
 order by customer_id)