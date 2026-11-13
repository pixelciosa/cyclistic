-- Remover datos de prueba e inválidos

delete from public.dataset_q1_19_20 as dq
where dq.start_station_name = 'HQ QR' or dq.ride_length < '00:00:00'