1. копируем всю папку

2. создаем и правим файл с переменными окружения

```bash
copy example.env .env
```
3. правим файл `.config/servers.json`
```bash
vim config/servers.json
```
>### Важно!  
>необходимо убрать комментарии, если они есть в json
```json
{
  "Servers": {
    "1": {
      "Name": "Local Postgres",  // имя локальной БД
      "Group": "Servers",
      "Host": "database",  // должен совпадать с именем сервиса в compose
      "Port": 5432,
      "MaintenanceDB": "db name",  // берем из .env значение POSTGRES_DB
      "Username": "user" //имя пользователя БД, берем из .env POSTGRES_USER
    }
  }
}
```



4. запускам сервер
```bash
docker compose up -d
```

>### Важно!  
>сервер не стартует мгновенно, нужно подождать 5-30 секунд прежде, чем заходить

5. приложение будет доступно в браузере по адресу:
```url
http://localhost:5050
```