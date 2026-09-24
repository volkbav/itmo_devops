-- Step 1
SET search_path = bookings, public;

Select bookings.now();

-- Step 2
EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT
    f.flight_id
    , f.departure_airport
    , f.arrival_airport
    , bp.seat_no
    , tf.amount AS price
FROM flights f
JOIN ticket_flights tf ON tf.flight_id = f.flight_id
LEFT JOIN boarding_passes bp ON bp.flight_id = f.flight_id
WHERE f.departure_airport IN ('SVO', 'DME', 'VKO')
    AND f.arrival_airport = 'LED'
    AND f.scheduled_departure > bookings.now()
    AND f.scheduled_departure < bookings.now() + INTERVAL '3 days'
ORDER BY f.scheduled_departure ASC
LIMIT 50;