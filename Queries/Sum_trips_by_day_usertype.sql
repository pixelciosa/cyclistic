-- cantidad de viajes según usertype cada día de la semana tipificado
SELECT 
	CASE day_of_week
        WHEN 1 THEN 'Sunday'
        WHEN 2 THEN 'Monday'
        WHEN 3 THEN 'Tuesday'
        WHEN 4 THEN 'Wednesday'
        WHEN 5 THEN 'Thursday'
        WHEN 6 THEN 'Friday'
        WHEN 7 THEN 'Saturday'
    END AS day_name,
	dq.member_casual as usertype,
	COUNT(ride_id) as riders_count,
	CASE
		when day_of_week in (7,1) then 'weekend' else 'week_day' end
	as day_type
FROM public.dataset_q1_19_20 AS dq
group by day_of_week, dq.member_casual 
order by riders_count DESC
