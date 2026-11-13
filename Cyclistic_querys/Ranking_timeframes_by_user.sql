-- Ranking the horarios segun tipo de usuarios 
select 
	ranking,
	usertype,
	start_hour,
	day,
	time_cat,
	riders_count
from (
	SELECT 
	dq.member_casual as usertype,
	extract(hour from dq.start_time) start_hour,
	CASE 
		when dq.day_of_week = 1 then 'Sunday'
		when dq.day_of_week = 2 then 'Monday'
		when dq.day_of_week = 3 then 'Tuesday'
		when dq.day_of_week = 4 then 'Wednesday'
		when dq.day_of_week = 5 then 'Thursday'
		when dq.day_of_week = 6 then 'Friday'
		when dq.day_of_week = 7 then 'Saturday'
	end
	as day,
	COUNT(ride_id) as riders_count,
	CASE
		when 
			dq.day_of_week in (2,3,4,5,6) and extract(hour from dq.start_time) in (7,8,9,16,17,18,19) then 'office_rush_hours' 
		when
			extract(hour from dq.start_time) in (0,1,2,3,4,5,6) then 'after_midnight' 
		when
			dq.day_of_week in (1,7) and extract(hour from dq.start_time) in (8,9,10,11,12,13,14,15,16,17,18,19) then 'weekend_day' 
		when
			dq.day_of_week in (1,7) and extract(hour from dq.start_time) in (20,21,22,23,0,1,2,3,4,5,6,7) then 'weekend_night' 
		else
			'other'
	END
	as time_cat,
	RANK() over(
		partition by dq.member_casual
		order by COUNT(ride_id) DESC
	) as ranking
FROM public.dataset_q1_19_20 AS dq
group by dq.member_casual, extract(hour from dq.start_time), dq.day_of_week
order by riders_count DESC
)

where ranking <= 10
order by usertype, ranking ASC

	