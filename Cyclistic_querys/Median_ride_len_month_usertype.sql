-- Duración media y promedio de viaje por mes y tipo de usuario
select 
	dq.member_casual as usertype,
	case
		when extract(month from dq.start_time) = 1 then 'January'
		when extract(month from dq.start_time) = 2 then 'February'
		when extract(month from dq.start_time) = 3 then 'March'
	end
	as month,
	round((PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY dq.ride_length_in_minutes)::decimal), 2) as median_length_in_minutes,
	round(AVG(dq.ride_length_in_minutes)::decimal, 2) as average_length_in_minutes
from public.dataset_q1_19_20 AS dq
group by dq.member_casual, extract(month from dq.start_time)

