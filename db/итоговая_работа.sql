-- 1

/* Берем таблицу airports, группируя по столбцу сity и у которых count больше 1 */
select city "Город"
from bookings.airports
group by city 
having count(*) > 1;

-- 2

/* Подзапрос получает код самолета с самыой большой дальностью
 * В основном запросе указываются условия 
 * Далее основой запрос получает имя аэропорта по join с таблице перелётов*/
select distinct 
	a.airport_name "Аэропорт"
from bookings.airports a  
join bookings.flights f on a.airport_code = f.departure_airport 
where f.aircraft_code = (
	select a.aircraft_code 
	from bookings.aircrafts a 
	order by a."range" desc limit 1
);

-- 3

/* Выбираем только рейсы которые вылетели 
 * Задержку можно посчитать обычным вычитанием 
 * Сортировка по убываню и лиимт на на вывод данных  */
select 
	f.flight_id,
	f.scheduled_departure,
	f.actual_departure,
	f.actual_departure - f.scheduled_departure "Задержка"
from bookings.flights f
where f.actual_departure is not null
order by "Задержка" desc
limit 10;

-- 4

/* Left join, т.к. нужно полное множество броней.
 * Соединяю таблицу tickets так как таблица связана с талонами через билеты */
select 
	case when count(b.book_ref) > 0 then 'были'
	else 'не были'
	end "Наличие броней без талонов",
	count(b.book_ref) "количество" 
from bookings.bookings b 
join bookings.tickets t on t.book_ref = b.book_ref 
left join bookings.boarding_passes bp on bp.ticket_no = t.ticket_no 
where bp.boarding_no is null;

-- 5
	
-- 6

/* Используется подзапрос для получения общего числа полетов
 * В основном запросе используется группировка по model */
select 
	a.model "Модель самолета",
	count(f.flight_id) "Количество рейсов",
	round(count(f.flight_id) /
		(select 
			count(f.flight_id)
		from flights f 
		where f.actual_departure is not null
		)::dec * 100, 4) "В процентах от общего числа"
from bookings.aircrafts a 
join bookings.flights f on f.aircraft_code = a.aircraft_code 
where f.actual_departure is not null
group by a.model;
 
-- 7

/* CTE max_min_by_city формирует мин стоимость по бизнес классу и макс по эконому
 * Групировка по городу отправления и прибытия и по классу билета.
 * результаты его отправляются во внешний запрос, который собирает минимум и максимум по двум городам в одну строку. 
 * В итоге выводятся только те строки, в которых min(b_min_amount) < max(e_max_amount). */
with max_min_by_city as(
	select 
		a.city dep_city,
		a2.city arr_city,
		tf.fare_conditions,
		case when tf.fare_conditions  = 'Business' then min(tf.amount) end b_min_amount,
		case when tf.fare_conditions  = 'Economy' then max(tf.amount) end e_max_amount
	from bookings.flights f 
	join bookings.ticket_flights tf on tf.flight_id = f.flight_id 
	join bookings.airports a on f.departure_airport = a.airport_code
	join bookings.airports a2 on f.arrival_airport = a2.airport_code
	group by (1, 2), 3
)
select 
	dep_city "Из", 
	arr_city "В", 
	min(b_min_amount) "min за бизнес", 
	max(e_max_amount) "max за эконом"
from max_min_by_city
group by (1, 2)
having min(b_min_amount) < max(e_max_amount);
 
-- 8

/* Создаем представление для получения городов, между которыми есть рейсы
 * Два join'а в представлении для получения города отправления и города прибытия
 * В основном запросе получаю декартово произведение всех городов, с условием их неравенства
 * И убираем данные, которые есть в представлении.*/
create view dep_arr_cit as
select distinct 
	a.city departure_city,
	a2.city arrival_city
from flights f 
join airports a on f.departure_airport = a.airport_code 
join airports a2 on f.arrival_airport = a2.airport_code;
 
select distinct 
	a.city departure_city,
	a2.city arrival_city 
from airports a, airports a2 
where a.city != a2.city
except 
select * from dep_arr_city
 
-- 9
