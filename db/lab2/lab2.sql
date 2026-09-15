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
    OR passenger_name LIKE 'E%'

--