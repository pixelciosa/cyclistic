-- Proporcion de viajes redondos
select
 usertype,
 ROUND(count_round_trips::NUMERIC/total, 2) as perc_round_trips
from (
select
	dq.member_casual as usertype,
	SUM(
		case when dq.start_station_id = dq.end_station_id then 1 else 0 end
	) as count_round_trips,
	SUM(
		case when dq.start_station_id <> dq.end_station_id then 1 else 0 end
	) as count_linear_trips,
	COUNT(distinct dq.ride_id) as total
FROM public.dataset_q1_19_20 AS dq
group by dq.member_casual
)