-- Задание 3
-- 1. отображение всех столбцов в таблице aircrafts
SELECT * FROM aircrafts;

-- 2. отображение только выбранные столбцы в таблице aircrafts
SELECT aircraft_code,
    model
FROM aircrafts;

-- 3. получение конкретных строк в таблице
SELECT model, range
FROM bookings,aircrafts_data
WHERE range < 5000;

-- 4. фильтрация данных с помощью сравнения строк
SELECT book_ref, passenger_id, passenger_name
FROM bookings.tickets
WHERE passenger_name LIKE 'V%'
    OR passenger_name LIKE 'E%';

-- 5. Получение диапазона значения
SELECT flight_no, scheduled_departure, scheduled_arrival,
    departure_airport, arrival_airport
FROM bookings.flights
WHERE departure_airport = 'DME'
    AND scheduled_departure between '2017-08-31' and '2017-09-01';

-- 6. Получение списка значений
SELECT flight_no, scheduled_departure, scheduled_arrival,
    departure_airport, arrival_airport
FROM bookings.flights
WHERE departure_airport = 'DME'
    AND arrival_airport IN ('LED', 'KZN')
    AND scheduled_departure between '2017-08-31' and '2017-09-01';

-- 7. Работа со значениями NULL
SELECT
    flight_no,
    scheduled_departure,
    scheduled_arrival,
    actual_departure,
    actual_arrival
FROM bookings.flights
WHERE departure_airport = 'DME'
    AND actual_departure = NULL;


SELECT
    flight_no,
    scheduled_departure,
    scheduled_arrival,
    actual_departure,
    actual_arrival
FROM bookings.flights
WHERE departure_airport = 'DME'
    AND actual_departure IS NULL;


SELECT
    flight_no,
    scheduled_departure,
    scheduled_arrival,
    COALESCE(actual_departure, '9999-12-31'),
    COALESCE(actual_arrival, '9999-12-31')
FROM bookings.flights
WHERE departure_airport = 'DME'
    AND arrival_airport = 'KZN';


SELECT
    flight_no,
    scheduled_departure,
    scheduled_arrival,
    COALESCE(actual_departure, '9999-12-31') AS "Actual Departure",
    COALESCE(actual_arrival, '9999-12-31') "Actual Arrival"
FROM bookings.flights
WHERE departure_airport = 'DME'
    AND arrival_airport = 'KZN';