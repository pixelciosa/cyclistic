-- Union de tablas 2019 y 2020 + calculate column ride_length_in_minutes

drop table if exists dataset_Q1_19_20;

create table dataset_Q1_19_20 as
select ride_id, start_time, end_time, ride_length, day_of_week, start_station_id, start_station_name, 
end_station_id, end_station_name, member_casual,
extract(EPOCH from (ride_length)) / 60.0 as ride_length_in_minutes
from dataset_cyclistic_Q1_2019
union all
select ride_id, start_time, end_time, ride_length, day_of_week, start_station_id, start_station_name, 
end_station_id, end_station_name, member_casual,
extract(EPOCH from (ride_length)) / 60.0 AS ride_length_in_minutes
from dataset_cyclistic_Q1_2020;

-- Crea un índice en la nueva tabla consolidada
create index idx__Q1_19_20_id on dataset_Q1_19_20(ride_id);