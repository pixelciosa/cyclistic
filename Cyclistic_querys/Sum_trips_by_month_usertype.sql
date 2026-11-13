-- cantidad de viajes según usertype por mes
SELECT 
	CASE
		when extract(month from dq.start_time) = 1 then 'January'
		when extract(month from dq.start_time) = 2 then 'February'
		when extract(month from dq.start_time) = 3 then 'March'
	end
	as month,
	dq.member_casual as usertype,
	COUNT(ride_id) as riders_count
FROM public.dataset_q1_19_20 AS dq
group by extract(month from dq.start_time), dq.member_casual 
order by riders_count DESC
