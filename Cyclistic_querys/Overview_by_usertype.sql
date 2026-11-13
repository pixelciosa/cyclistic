-- overview by usertype
SELECT 
	dq.member_casual as usertype,
	COUNT(ride_id) as count, 
	ROUND( (COUNT(*) * 100) /SUM(COUNT(*)) OVER(), 2) as percentage,
	ROUND(MIN(dq.ride_length_in_minutes), 2) as min_ride_in_minutes,
	ROUND(AVG(dq.ride_length_in_minutes), 2) as average_ride_in_minutes,
	PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY ROUND(dq.ride_length_in_minutes, 2)) as median_ride_in_minutes,
	ROUND(MAX(dq.ride_length_in_minutes), 2) as max_ride_in_minutes,
	MODE() WITHIN GROUP(ORDER BY dq.day_of_week) as most_common_day    
FROM public.dataset_q1_19_20 AS dq
group by dq.member_casual
