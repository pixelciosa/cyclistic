-- Duración media y promedio de viaje por dia y tipo de usuario
select 
	dq.member_casual as usertype,
	case 
		when dq.day_of_week = 1 then 'Sunday'
		when dq.day_of_week = 2 then 'Monday'
		when dq.day_of_week = 3 then 'Tuesday'
		when dq.day_of_week = 4 then 'Wednesday'
		when dq.day_of_week = 5 then 'Thursday'
		when dq.day_of_week = 6 then 'Friday'
		when dq.day_of_week = 7 then 'Saturday'
	end
	as day_of_week,
	round((PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY dq.ride_length_in_minutes)::decimal), 2) as median_length_in_minutes,
	round(AVG(dq.ride_length_in_minutes)::decimal, 2) as average_length_in_minutes
from public.dataset_q1_19_20 AS dq
group by dq.member_casual, dq.day_of_week

