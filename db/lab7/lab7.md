# Запрос к ИИ
Запрос sql
```sql
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
```
Результат:
```
1.	 Limit (cost=53701.25..53701.38 rows=50 width=29) (actual=341.374..341.382 rows=50 loops=1)	0.005 ms	341.382 ms	↑ 1	50	50	1
2.	 Sort (cost=53701.25..53763.49 rows=24896 width=29) (actual=341.373..341.378 rows=50 loops=1)	5.13 ms	341.378 ms	↑ 497.92	50	24896	1
3.	 Nested Loop Left Join (cost=2352.26..52874.23 rows=24896 width=29) (actual=21.806..336.248 rows=28400 loops=1)	4.771 ms	336.248 ms	↓ 1.15	28400	24896	1
4.	 Hash Inner Join (cost=2351.82..51821.45 rows=863 width=26) (actual=21.791..331.477 rows=2228 loops=1)
Хэш-условие: (tf.flight_id = f.flight_id)
166.367 ms	331.477 ms	↓ 2.59	2228	863	1
5.	 Seq Scan on ticket_flights as tf (cost=0..43273.35 rows=2360335 width=10) (actual=0.053..159.398 rows=2360335 loops=1)	159.398 ms	159.398 ms	↑ 1	2360335	2360335	1
6.	 Hash (cost=2351.52..2351.52 rows=24 width=20) (actual=5.711..5.712 rows=36 loops=1)
Buckets: 1024 Batches: 1 Использование памяти: 10 kB
0.01 ms	5.712 ms	↓ 1.5	36	24	1
7.	 Seq Scan on flights as f (cost=0..2351.52 rows=24 width=20) (actual=0.054..5.702 rows=36 loops=1)
Фильтр: ((scheduled_departure > '2017-08-15 15:00:00+00'::timestamp with time zone) AND (arrival_airport = 'LED'::bpchar) AND (departure_airport = ANY ('{SVO,DME,VKO}'::bpchar[])) AND (scheduled_departure < ('2017-08-15 15:00:00+00'::timestamp with time zone + '3 days'::interval)))
Строки, удаленные фильтром: 65628
5.702 ms	5.702 ms	↓ 1.5	36	24	1
8.	 Memoize (cost=0.44..5.89 rows=83 width=7) (actual=0..0.001 rows=12 loops=2228)
Buckets: Batches: Использование памяти: 11 kB
0.001 ms	0.001 ms	↑ 6.92	12	83	2228
9.	 Index Only Scan using boarding_passes_flight_id_seat_no_key on boarding_passes as bp (cost=0.43..5.88 rows=83 width=7) (actual=0.002..0.003 rows=11 loops=21)
Индекс состояния: (flight_id = f.flight_id)
0.001 ms	0.001 ms	↑ 0.01	11	83	21
```
Проанализируй этот план. Почему при поиске за 3 дня база начинает
активно использовать диск (Disk Usage)?

# Ответ ИИ
Да. Здесь причина довольно хорошо видна из плана: основная проблема не в поиске flights за 3 дня, а в том, что PostgreSQL сначала полностью читает ticket_flights и строит Hash Join.

Разберём по узлам.

1. Самый дорогой узел — ticket_flights
Seq Scan on ticket_flights as tf
(actual=0.053..159.398 rows=2360335)

Таблица содержит примерно 2.36 млн строк, и PostgreSQL читает всю таблицу:

rows=2360335

Это занимает ~159 ms только на чтение.

Причина — условие соединения:

tf.flight_id = f.flight_id

А подходящего индекса на ticket_flights.flight_id, судя по плану, нет либо оптимизатор не считает его полезным.

2. flights отфильтровывается очень хорошо

Вот этот узел:

Seq Scan on flights as f
actual=0.054..5.702 rows=36

PostgreSQL просмотрел примерно 65 тысяч строк:

Строки, удаленные фильтром: 65628

и оставил всего:

rows=36

То есть условие:

WHERE f.departure_airport IN ('SVO', 'DME', 'VKO')
  AND f.arrival_airport = 'LED'
  AND f.scheduled_departure > ...
  AND f.scheduled_departure < ... + interval '3 days'

находит всего 36 рейсов.

И вот здесь возникает интересная ситуация.

3. Почему же PostgreSQL не делает 36 быстрых поисков в ticket_flights?

Потому что ему нужно соединить:

36 flights
       ↓
ticket_flights

Теоретически хороший план мог бы выглядеть примерно так:

Index Scan flights
        ↓
Nested Loop
        ↓
Index Scan ticket_flights WHERE flight_id = ?

То есть:

нашли 36 рейсов → для каждого быстро нашли билеты.

Но PostgreSQL выбрал другой вариант:

Seq Scan ticket_flights
        ↓
     Hash Join
        ↑
36 flights → Hash

То есть:

прочитаем все 2.36 млн ticket_flights, а потом оставим только нужные.

Именно поэтому здесь:

Hash Inner Join
actual=21.791..331.477 rows=2228

причём:

estimated rows=863
actual rows=2228
4. А где появляется Disk Usage?

Вот здесь важный момент.

В показанном тобой фрагменте сам Sort не показывает Disk.

У тебя:

Sort
(cost=53701.25..53763.49 rows=24896)
(actual=341.373..341.378 rows=50)

Если это вывод твоего инструмента визуализации плана, колонка Disk Usage может отображаться отдельно от приведённых тобой полей.

Но принципиально:

LIMIT 50 не означает, что PostgreSQL может сразу остановиться.

У тебя:

ORDER BY f.scheduled_departure ASC
LIMIT 50

Чтобы вернуть первые 50 строк, PostgreSQL должен знать, какие строки являются первыми по:

f.scheduled_departure

А до сортировки он получил:

28400 rows

из:

Nested Loop Left Join
actual ... rows=28400

То есть схема примерно такая:

36 flights
    ↓
2228 ticket_flights
    ↓
LEFT JOIN boarding_passes
    ↓
28400 строк
    ↓
SORT
    ↓
50 строк

Вот это уже потенциально создаёт большой объём промежуточных данных.

5. Особенно интересно вот это

Оптимизатор ожидал:

Nested Loop Left Join
rows=24896

а получил:

actual rows=28400

То есть оценка относительно близкая.

Но выше:

Hash Join
estimated: 863
actual:    2228

Здесь ошибка уже примерно в 2.6 раза:

↓ 2.59

Это влияет на выбор плана.

6. Почему при 1 дне может быть нормально, а при 3 днях — Disk Usage?

Это очень характерная ситуация.

Допустим:

1 день
flights → 10
ticket_flights → 500
результат JOIN → 5000

PostgreSQL может спокойно обработать всё в памяти.

3 дня
flights → 36
ticket_flights → 2228
JOIN → 28400

А если добавить ещё другие условия/дублирование из boarding_passes, промежуточный набор становится ещё больше.

Если объём данных, который должен обработать Sort или другой узел, превышает доступную ему память (work_mem), PostgreSQL начинает использовать temporary files на диске.

То есть:

RAM
 ↓
work_mem
 ↓ превышен
temporary files
 ↓
DISK

Это и есть тот самый Disk Usage.

7. Но есть ещё одна проблема в запросе

Обрати внимание:

JOIN ticket_flights tf
    ON tf.flight_id = f.flight_id

LEFT JOIN boarding_passes bp
    ON bp.flight_id = f.flight_id

Ты соединяешь ticket_flights и boarding_passes только по flight_id.

Если у рейса:

ticket_flights = 100
boarding_passes = 100

то результат может содержать:

100 × 100 = 10 000 строк

То есть возникает размножение строк.

В твоём случае:

2228
 ↓
28400

Поэтому обязательно стоит проверить, действительно ли тебе нужно такое соединение.

Если ты хочешь получить:

каждый билет + соответствующий boarding pass

то соединять таблицы только по flight_id может быть неправильно.

Обычно там нужен более специфичный ключ, например ticket_no, в зависимости от структуры БД.

8. Что я бы проверил первым
Шаг 1 — индекс ticket_flights

Выполни:

\d bookings.ticket_flights

и посмотри, есть ли:

INDEX ... (flight_id)

Если нет — это очень вероятный кандидат:

CREATE INDEX idx_ticket_flights_flight_id
ON bookings.ticket_flights (flight_id);

Тогда PostgreSQL потенциально сможет сделать:

36 flights
   ↓
Nested Loop
   ↓
Index Scan ticket_flights

вместо:

Seq Scan 2.36 million rows
   ↓
Hash Join
Шаг 2 — посмотреть настоящий EXPLAIN

Я бы ещё запустил:

EXPLAIN (ANALYZE, BUFFERS, VERBOSE)
SELECT
    f.flight_id,
    f.departure_airport,
    f.arrival_airport,
    bp.seat_no,
    tf.amount AS price
FROM flights f
JOIN ticket_flights tf
    ON tf.flight_id = f.flight_id
LEFT JOIN boarding_passes bp
    ON bp.flight_id = f.flight_id
WHERE f.departure_airport IN ('SVO', 'DME', 'VKO')
    AND f.arrival_airport = 'LED'
    AND f.scheduled_departure > bookings.now()
    AND f.scheduled_departure < bookings.now() + INTERVAL '3 days'
ORDER BY f.scheduled_departure ASC
LIMIT 50;

Особенно интересны строки вида:

Sort Method: external merge  Disk: xxxx kB

Если увидим:

Sort Method: external merge
Disk: ...

— тогда точно подтверждается, что сортировка вышла из work_mem на диск.

Итого

В твоём плане цепочка такая:

flights
  │
  │ 36 подходящих рейсов
  ▼
Hash
  │
  │
  ├────────────── ticket_flights
  │               │
  │               └── Seq Scan 2.36 млн строк
  │
  ▼
2228 строк
  │
  ▼
LEFT JOIN boarding_passes
  │
  ▼
28400 строк
  │
  ▼
SORT
  │
  ▼
LIMIT 50

Главный подозреваемый №1: отсутствие/неиспользование индекса ticket_flights(flight_id).

Главный подозреваемый №2: размножение строк из-за JOIN ticket_flights + LEFT JOIN boarding_passes только по flight_id.

Disk Usage возникает не потому, что PostgreSQL «ищет три дня на диске». Увеличение диапазона даёт больше промежуточных строк, а операция вроде Sort при превышении work_mem может перейти на временные файлы на диске.

Если покажешь EXPLAIN (ANALYZE, BUFFERS) именно с Sort Method и Buffers, можно будет точно определить, какой узел начал писать на диск и сколько именно, а не предполагать.


# Решение
```sql
CREATE INDEX idx_ticket_flights_flight_id
ON bookings.ticket_flights (flight_id);
```

# Результат после индексирования
```
	#	Node	Timings	Строки	Loops
Exclusive	Inclusive	Строки X	Actual	Plan
1.	 Limit (cost=11831.41..11831.53 rows=50 width=29) (actual=24.08..24.086 rows=50 loops=1)	0.005 ms	24.086 ms	↑ 1	50	50	1
2.	 Sort (cost=11831.41..11893.65 rows=24896 width=29) (actual=24.079..24.081 rows=50 loops=1)	4.49 ms	24.081 ms	↑ 497.92	50	24896	1
3.	 Nested Loop Left Join (cost=0.87..11004.38 rows=24896 width=29) (actual=0.059..19.591 rows=28400 loops=1)	4.463 ms	19.591 ms	↓ 1.15	28400	24896	1
4.	 Nested Loop Inner Join (cost=0.43..9951.6 rows=863 width=26) (actual=0.053..15.127 rows=2228 loops=1)	9.661 ms	15.127 ms	↓ 2.59	2228	863	1
5.	 Seq Scan on flights as f (cost=0..2351.52 rows=24 width=20) (actual=0.023..5.204 rows=36 loops=1)
Фильтр: ((scheduled_departure > '2017-08-15 15:00:00+00'::timestamp with time zone) AND (arrival_airport = 'LED'::bpchar) AND (departure_airport = ANY ('{SVO,DME,VKO}'::bpchar[])) AND (scheduled_departure < ('2017-08-15 15:00:00+00'::timestamp with time zone + '3 days'::interval)))
Строки, удаленные фильтром: 65628
5.204 ms	5.204 ms	↓ 1.5	36	24	1
6.	 Index Scan using idx_ticket_flights_flight_id on ticket_flights as tf (cost=0.43..315.82 rows=85 width=10) (actual=0.007..0.263 rows=62 loops=36)
Индекс состояния: (flight_id = f.flight_id)
0.263 ms	0.263 ms	↑ 1.38	62	85	36
7.	 Memoize (cost=0.44..5.89 rows=83 width=7) (actual=0..0.001 rows=12 loops=2228)
Buckets: Batches: Использование памяти: 11 kB
0.001 ms	0.001 ms	↑ 6.92	12	83	2228
8.	 Index Only Scan using boarding_passes_flight_id_seat_no_key on boarding_passes as bp (cost=0.43..5.88 rows=83 width=7) (actual=0.004..0.004 rows=11 loops=21)
Индекс состояния: (flight_id = f.flight_id)
0.001 ms	0.001 ms	↑ 0.01	11	83	21
```


Далее ИИ предлагает внести изменения в SELECT