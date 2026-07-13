https://distribution.github.io/distribution/about/deploying/

- получение сертификата (без него нельзя будет запустить аутентификацию пользователя)
```bash
mkdir -p certs

openssl req -newkey rsa:4096 -nodes -sha256 \
  -keyout certs/domain.key \
  -x509 -days 365 \
  -out certs/domain.crt \
  -subj "/CN=localhost"
```

- создание файла с паролем:
```bash
mkdir auth
```
```bash
docker run \
  --entrypoint htpasswd \
  httpd:2 -Bbn testuser testpassword > auth/htpasswd
```
- останавливаем контейнет (если запущен)
```bash
docker container stop registry
```
- запускаем повторно:

```bash
docker run -d \
  -p 5000:5000 \
  --restart=always \
  --name registry \
  -v "$(pwd)"/auth:/auth \
  -e "REGISTRY_AUTH=htpasswd" \
  -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
  -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
  -v "$(pwd)"/certs:/certs \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
  registry:3
```

- проверяем
```bash
docker login <домен>:5000  # можно использовать localhost
```