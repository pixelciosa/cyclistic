-- Proporción de viajes redondos segun día y hora del día, por tipo de usuario

select
 sq.usertype,
 sq.day_name,
 sq.hour,
 ROUND(sq.count_round_trips::NUMERIC/sq.total, 2) as perc_round_trips
from (
select
	dq.member_casual as usertype,
	CASE day_of_week
        WHEN 1 THEN 'Sunday'
        WHEN 2 THEN 'Monday'
        WHEN 3 THEN 'Tuesday'
        WHEN 4 THEN 'Wednesday'
        WHEN 5 THEN 'Thursday'
        WHEN 6 THEN 'Friday'
        WHEN 7 THEN 'Saturday'
    END AS day_name,
	EXTRACT(hour from dq.start_time) as hour,
	SUM(
		case when dq.start_station_id = dq.end_station_id then 1 else 0 end
	) as count_round_trips,
	SUM(
		case when dq.start_station_id <> dq.end_station_id then 1 else 0 end
	) as count_linear_trips,
	COUNT(distinct dq.ride_id) as total
FROM public.dataset_q1_19_20 AS dq
group by dq.member_casual, dq.day_of_week, EXTRACT(hour from dq.start_time)
) as sq
order by perc_round_trips desc 