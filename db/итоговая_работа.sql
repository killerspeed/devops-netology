-- 1

/* ����� ������� airports, ��������� �� ������� �ity � � ������� count ������ 1 */
select city "�����"
from bookings.airports
group by city 
having count(*) > 1;

-- 2

/* ��������� �������� ��� �������� � ������ ������� ����������
 * � �������� ������� ����������� ������� 
 * ����� ������� ������ �������� ��� ��������� �� join � ������� ��������*/
select distinct 
	a.airport_name "��������"
from bookings.airports a  
join bookings.flights f on a.airport_code = f.departure_airport 
where f.aircraft_code = (
	select a.aircraft_code 
	from bookings.aircrafts a 
	order by a."range" desc limit 1
);

-- 3

/* �������� ������ ����� ������� �������� 
 * �������� ����� ��������� ������� ���������� 
 * ���������� �� ������� � ����� �� �� ����� ������  */
select 
	f.flight_id,
	f.scheduled_departure,
	f.actual_departure,
	f.actual_departure - f.scheduled_departure "��������"
from bookings.flights f
where f.actual_departure is not null
order by "��������" desc
limit 10;

-- 4

/* Left join, �.�. ����� ������ ��������� ������.
 * �������� ������� tickets ��� ��� ������� ������� � �������� ����� ������ */
select 
	case when count(b.book_ref) > 0 then '����'
	else '�� ����'
	end "������� ������ ��� �������",
	count(b.book_ref) "����������" 
from bookings.bookings b 
join bookings.tickets t on t.book_ref = b.book_ref 
left join bookings.boarding_passes bp on bp.ticket_no = t.ticket_no 
where bp.boarding_no is null;

-- 5
	
-- 6

/* ������������ ��������� ��� ��������� ������ ����� �������
 * � �������� ������� ������������ ����������� �� model */
select 
	a.model "������ ��������",
	count(f.flight_id) "���������� ������",
	round(count(f.flight_id) /
		(select 
			count(f.flight_id)
		from flights f 
		where f.actual_departure is not null
		)::dec * 100, 4) "� ��������� �� ������ �����"
from bookings.aircrafts a 
join bookings.flights f on f.aircraft_code = a.aircraft_code 
where f.actual_departure is not null
group by a.model;
 
-- 7

/* CTE max_min_by_city ��������� ��� ��������� �� ������ ������ � ���� �� �������
 * ���������� �� ������ ����������� � �������� � �� ������ ������.
 * ���������� ��� ������������ �� ������� ������, ������� �������� ������� � �������� �� ���� ������� � ���� ������. 
 * � ����� ��������� ������ �� ������, � ������� min(b_min_amount) < max(e_max_amount). */
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
	dep_city "��", 
	arr_city "�", 
	min(b_min_amount) "min �� ������", 
	max(e_max_amount) "max �� ������"
from max_min_by_city
group by (1, 2)
having min(b_min_amount) < max(e_max_amount);
 
-- 8

/* ������� ������������� ��� ��������� �������, ����� �������� ���� �����
 * ��� join'� � ������������� ��� ��������� ������ ����������� � ������ ��������
 * � �������� ������� ������� ��������� ������������ ���� �������, � �������� �� �����������
 * � ������� ������, ������� ���� � �������������.*/
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
