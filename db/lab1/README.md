1. копируем всю папку

2. создаем и правим файл с переменными окружения

```bash
copy example.env .env
```
3. правим файл `.config/servers.json
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
      "MaintenanceDB": "itmo_lab",  // берем из .env значение POSTGRES_DB
      "Username": "alex" //имя пользователя БД, берем из .env POSTGRES_USER
    }
  }
}
```



4. запускам сервер
```bash
docker compose up -d
```