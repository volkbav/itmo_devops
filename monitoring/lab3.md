Установит grafana в docker  
Добавить vm как datasource   
Нарисовать grafana дашборд для node exporter с 2-3 графиками для потребления cpu и памяти  
Отчет либо в виде скринов либо в виде экспортированного файла с дашбордой 


## Методичка ai
# Lab 3. Grafana + VictoriaMetrics + Node Exporter

Цель лабораторной — развернуть Grafana в Docker, подключить VictoriaMetrics как источник данных и собрать дашборд для мониторинга CPU и оперативной памяти Linux.

Будем использовать результаты предыдущих лабораторных: VictoriaMetrics уже запущена в Docker, а метрики должны поступать от Node Exporter.

## Что должно получиться

VictoriaMetrics

Хранит метрики и выполняет запросы PromQL

8428

Grafana

Подключается к VictoriaMetrics и отображает графики

3000

В итоге сделаем три панели:

1. Загрузка CPU по каждому ядру — в процентах.
2. Использование RAM — в процентах.
3. Объём занятой и доступной RAM — в гигабайтах.

Сохраним дашборд в JSON-файл для отчёта.

## Шаг 1. Проверяем VictoriaMetrics и Node Exporter

На машине `dev-env`, где у тебя запущена VictoriaMetrics, выполни:

```
docker ps
```

Убедись, что контейнер `victoria-metrics` работает.

Проверь API:

```
curl -s http://localhost:8428/api/v1/query \
  --data-urlencode 'query=up'
```

В ответе должен быть JSON с результатами запроса. Если `up` возвращает значение `1` для Node Exporter, сбор метрик работает.

Если Node Exporter запущен на другом хосте, проверь, что в VictoriaMetrics действительно поступают его метрики:

```
curl -s http://localhost:8428/api/v1/query \
  --data-urlencode 'query=node_cpu_seconds_total'
```

Если результат пустой, сначала исправь сбор метрик — Grafana сама их не собирает.

## Шаг 2. Запускаем Grafana в Docker

Перейди в каталог лабораторной:

```
cd ~/projects/itmo_devops/monitoring
```

Создай постоянный Docker volume, чтобы настройки Grafana не пропали при пересоздании контейнера:

```
docker volume create grafana-data
```

Запусти Grafana:

```
docker run -d \
  --name grafana \
  --restart=unless-stopped \
  -p 3000:3000 \
  -v grafana-data:/var/lib/grafana \
  grafana/grafana
```

Это официальный образ Grafana. Данные сохраняются в томе `grafana-data`.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://grafana.com\&sz=32)

Grafana documentation



Проверь запуск:

```
docker ps --filter name=grafana
docker logs --tail=50 grafana
```

Открой в браузере:

`http://localhost:3000`

Если работаешь с удалённым `dev-env`, используй IP этого сервера, например `http://IP_СЕРВЕРА:3000`. При необходимости проверь настройки firewall.

Войди в Grafana. При первом запуске стандартные учётные данные:

- логин: `admin`
- пароль: `admin`

При первом входе Grafana обычно предложит сменить пароль.

## Шаг 3. Добавляем VictoriaMetrics как Data Source

Grafana должна знать, откуда брать данные. В этой лабораторной источником будет VictoriaMetrics.

Открой в Grafana:

1. Connections → Data sources (в некоторых версиях раздел доступен через Administration).
2. Нажми Add data source.
3. Выбери Prometheus.

Отдельный плагин VictoriaMetrics для этой лабораторной не обязателен: встроенный источник Prometheus умеет работать с совместимым API VictoriaMetrics.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://grafana.com\&sz=32)

Grafana documentation+1



Заполни настройки:

### Настройки источника

Пример для Grafana в Docker на Linux, а VictoriaMetrics доступна через порт хоста 8428.

Имя

VictoriaMetrics

Prometheus server URL

http\://IP_СЕРВЕРА_DEV_ENV:8428

Замени IP_СЕРВЕРА_DEV_ENV на реальный IP машины, на которой запущена VictoriaMetrics. Не вводи этот текст буквально.

Почему не `http://localhost:8428`? Grafana работает внутри отдельного контейнера, поэтому `localhost` указывает на сам контейнер Grafana, а не на хост с VictoriaMetrics.

В конце страницы нажми Save & test.

Ожидаемый результат — сообщение об успешном подключении к источнику данных. Если возникла ошибка, проверь доступность порта 8428 с машины, где работает Grafana, и адрес в настройках.

## Шаг 4. Создаём дашборд

В левом меню Grafana:

1. Открой Dashboards.
2. Нажми New → New dashboard.
3. Нажми Add visualization.
4. Выбери источник `VictoriaMetrics`.

Создадим три панели.

### Панель 1. Загрузка CPU по каждому ядру

В редакторе запроса переключись на режим Code и вставь:

```
100 * (
  1 - avg by (instance, cpu) (
    rate(node_cpu_seconds_total{mode="idle"}[5m])
  )
)
```

Настройки панели:

- Title: `CPU Usage by Core`
- Visualization: Time series
- Unit: Percent (0–100)
- Legend: `{{instance}} / CPU {{cpu}}`

Этот запрос показывает процент времени, когда каждое ядро было занято за последние пять минут.

Нажми Apply, чтобы сохранить панель в дашборде.

### Панель 2. Использование оперативной памяти

Добавь ещё одну визуализацию с запросом:

```
100 * (
  1 -
  node_memory_MemAvailable_bytes
  /
  node_memory_MemTotal_bytes
)
```

Настройки:

- Title: `Memory Usage`
- Visualization: Time series
- Unit: Percent (0–100)
- Legend: `{{instance}}`

Панель покажет процент используемой памяти с учётом определения доступной RAM в Linux.

### Панель 3. Использование памяти в гигабайтах

Добавь третью панель с двумя запросами.

Запрос A — занятая память:

```
(
  node_memory_MemTotal_bytes
  -
  node_memory_MemAvailable_bytes
) / 1024^3
```

Запрос B — доступная память:

```
node_memory_MemAvailable_bytes / 1024^3
```

Настройки панели:

- Title: `Memory Used vs Available`
- Visualization: Time series
- Unit: Gibibytes (GiB)
- Legend для A: `Used`
- Legend для B: `Available`

Так будет видно не только процент использования, но и объём памяти в абсолютных величинах.

Если запросы не возвращают данные, проверь имена метрик в Explore и убедись, что выбран правильный Data Source.

## Шаг 5. Приводим дашборд в порядок

Расположи панели так, чтобы они читались сверху вниз:

## Linux Node Exporter

Пример расположения панелей — реальные графики появятся в Grafana после настройки источника и запросов.

### CPU Usage by Core

Загрузка ядер, % — условная иллюстрация

### Memory Usage

# — %

Занятая RAM

### Memory Used vs Available

# — GiB

Объём памяти

При желании настрой общий временной диапазон, например Last 15 minutes, и интервал автообновления 30s. Эти настройки удобно использовать для демонстрации мониторинга в реальном времени.

После этого нажми Save dashboard и задай название, например `Linux Node Exporter`.

## Шаг 6. Экспортируем отчёт

Есть два способа сдать лабораторную. Лучше сохранить и JSON, и скриншот.

### Вариант A — экспорт JSON

1. Открой созданный дашборд.
2. Нажми меню Share или меню дашборда (название зависит от версии Grafana).
3. Перейди к Export.
4. Выбери экспорт в JSON и скачай файл, например `linux-node-exporter.json`.

В JSON сохраняются настройки панелей, запросы и расположение графиков. Экспорт не содержит сами исторические данные метрик и не гарантирует автоматическое подключение к твоему источнику данных при импорте в другой экземпляр Grafana.

Если при экспорте предлагается включить настройку Export for sharing externally, используй её для переносимого файла и проверь, что при импорте можно выбрать свой Data Source.

### Вариант B — скриншоты

Сделай скриншот итогового дашборда, на котором видны все три панели. Дополнительно полезно сохранить скриншот настроек Data Source с успешным результатом Save & test.

## Шаг 7. Проверяем, что лабораторная готова

### Чек-лист Lab 3

0/6

Grafana запущена в Docker и открывается в браузере

VictoriaMetrics добавлена как Data Source

Save & test завершился успешно

Построен график загрузки CPU по ядрам

Построены две панели по использованию RAM

Дашборд сохранён, JSON экспортирован или сделаны скриншоты

### Что можно написать в выводе отчёта

> В ходе лабораторной работы была развёрнута Grafana в Docker и настроено подключение к VictoriaMetrics в качестве источника данных. На основе метрик Node Exporter создан дашборд для визуализации загрузки CPU по ядрам, процента использования оперативной памяти и объёма занятой и доступной RAM. Дашборд сохранён и экспортирован для дальнейшего использования.

Официальная документация для справки:

- [Установка Grafana в Docker](https://grafana.com/docs/grafana/latest/setup-grafana/installation/docker/?utm_source=chatgpt.com)
- [Интеграция VictoriaMetrics с Grafana](https://docs.victoriametrics.com/victoriametrics/integrations/grafana/?utm_source=chatgpt.com)
- [Работа с дашбордами Grafana](https://grafana.com/docs/grafana/latest/dashboards/?utm_source=chatgpt.com)