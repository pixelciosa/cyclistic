-- El top 10 de estaciones de recogida y entrega segun tipo de usuario
with ranking_start_station as (
	select
	 dq.member_casual as usertype,
	 COUNT(dq.start_station_name) as start_count,
	 RANK() OVER(
	 	partition by member_casual
	 	order by COUNT(dq.start_station_name) DESC
	 	) as start_ranking,
	 dq.start_station_name as start_station
	FROM public.dataset_q1_19_20 AS dq
	where dq.start_station_name is not null
	group by dq.start_station_name, dq.member_casual
),
ranking_end_station as (
	select
	 dq.member_casual as usertype,
	 COUNT(dq.end_station_name) as end_count,
	 RANK() OVER(
	 	partition by member_casual
	 	order by COUNT(dq.end_station_name) DESC
	 	) as end_ranking,
	 dq.end_station_name as end_station
	FROM public.dataset_q1_19_20 AS dq
	where dq.end_station_name is not null
	group by dq.end_station_name, dq.member_casual
)

select
	s.usertype,
	s.start_count,
	s.start_ranking,
	s.start_station,
	e.end_count,
	e.end_ranking,
	e.end_station
from ranking_start_station as s
inner join ranking_end_station as e
on s.usertype = e.usertype and s.start_ranking = e.end_ranking
where s.start_ranking <= 10
order by usertype, s.start_ranking 
;
