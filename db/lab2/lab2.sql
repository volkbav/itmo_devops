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
    COALESCE(actual_departure, '9999-12-31'), -- пучтые меняем на значение...
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

SELECT
    scheduled_departure,
    flight_no,
    COALESCE(actual_departure::varchar, 'CANCELED') AS "Actual Departure"
FROM bookings.flights
WHERE departure_airport = 'DME'
    AND arrival_airport = 'KZN';


-- 8. Сортировка данных
SELECT
    scheduled_departure,
    flight_no,
    departure_airport,
    arrival_airport
FROM bookings.flights
WHERE departure_airport = 'DME'
ORDER BY arrival_airport;  -- сортировка по аэропорту прибытия

SELECT
    scheduled_departure,
    flight_no,
    departure_airport,
    arrival_airport
FROM bookings.flights
WHERE departure_airport = 'DME'
ORDER BY arrival_airport, scheduled_departure;  -- сортировка по аэропорту прибытия и времени вылета


-- 9. Устранение дублирования строк
SELECT DISTINCT
    departure_airport,
    arrival_airport
FROM bookings.flights
ORDER BY 1, 2;


-- 10. Использование выражений
SELECT
    scheduled_departure,
    'from '  || departure_airport::varchar || ' to '
        || arrival_airport:: varchar AS Destination,
    status
FROM bookings.flights;

/*
'from ' - вставка текста
|| departure_airport::varchar - преобразовали в текст
|| ' to ' - - вставка текста
|| arrival_airport:: varchar - преобразовали в текст
AS Destination, - дали название столбцу
*/

SELECT
    book_ref,
    substring(passenger_name from 1 for position(' ' in passenger_name)) as Name,
    substring(passenger_name from position(' ' in passenger_name)) as Surname
FROM bookings.tickets;


-- 11. Агрегатные функции
SELECT
    AVG(amount) AS Average,
    SUM(amount) AS Summary
FROM bookings.ticket_flights
WHERE fare_conditions = 'Economy';

SELECT
    COUNT(*)
FROM bookings.ticket_flights
WHERE fare_conditions = 'Economy'


--12. Использование Агрегатных функций с NULL
SELECT
    COUNT(*)
FROM bookings.flights
WHERE COALESCE(actual_arrival::date, '2017-06-12') = '2017-06-12';

