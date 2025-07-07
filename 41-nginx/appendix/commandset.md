# Less41. Nginx 

## Nginx
  -  Один из самых популярных в мире
  -  Разработан Игорем Сысоевым (первые версии)
  -  Легковесный
  -  Высокопроизводительный
  -  Может работать как веб-сервер, прокси, балансировщик, кэш
  -  HTTP/1.1, HTTP/2, HTTP/3, TLS 1.3, Gzip, Brotli…
  -  Форк от создателей: Angie (https://angie.software/

### Nginx конфигурация
  -  Основной конфиг: /etc/nginx/nginx.conf
  -  Подключение дополнительных конфигов: include /etc/nginx/conf.d/*.conf;
  -  Отдельные сайты: блоки server { }
  -  Выбор сайта для обработки: директивы listen и server_name
  -  Конфигурация по URL: блоки location {}
  -  Синтаксис: директивы всегда заканчиваются “;”
  -  Директивы наследуются
  -  Некоторые блоки могут иметь вложенность
  -  Документация: http://nginx.org/ru/docs/

## Angie
  -  Форк Nginx с отдельной командой
  -  Вся функциональность Nginx
  -  Встроенные средства мониторинга
  -  Консоль с веб-интерфейсом
  -  ACME-модуль (TLS сертификаты)
  -  Готовые бинарные пакеты в репозитории
  -  https://angie.software/

### Отличия Angie
  -  Поддержка HTTP/3 при соединении с бэкендами
  -  Возможность автоматически обновлять списки проксируемых серверов, соответствующих доменному имени, и получать эти списки из DNS-записей SRV
  -  Режим привязки сессий (sticky), при котором все запросы в рамках одной сессии будут направляться на один и тот же проксируемый сервер
  -  Механизм плавного ввода проксируемого сервера в работу после сбоя с помощью опции slow_start директивы server
https://angie.software/http_upstream/ https://angie.software/stream_upstream/


### Порядок поиска сервера по имени
1. Точное имя: www.example.org
2. Cамое длинное * в начале: "*.example.org"
3. Самое длинное * в конце: "api.*"
4. Первое подходящее регулярное выражение (в порядке следования в
конфигурационном файле)
1. Если нет совпадений: default_server

### Несколько доменов в одном сервере
```bash server {
server_name ~^(www\.)?(?<domain>.+)$; # www.site1.com site2.com
root /sites/$domain; # /sites/site1.com или /sites/site2.com
}
```
  -  Выбор корня в зависимости от домена
  -  Осторожно с настройкой TLS-сертификатов

### Приоритеты видов location
1. = — точное совпадение (префиксный location)
    ```bash
    location = / { ... }
    ```
2. ^~ — префиксный location без поиска regex
    ```bash 
    location ^~ /images { ... }
    ```
3. ~ или ~* — регулярное выражение (с учётом и без учёта регистра)
    ```bash
    location ~* ^/.* { ... }
    ```
4. префиксный location без модификатора
    ```bash
    location / { ... }
    ```

### Особенность обработки location
  -  Если location оканчивается на /: location /uri/ { }
  -  Используется proxy_pass
  -  Запрос без /: /uri
  -  Получаем редирект на /uri/
  -  Для обхода делаем 2 location
```bash 
location /uri/ { }
location = /uri { }
```

### Именованный location
  -  Определяется через @
  -  Используется только для перенаправлений
  -  Пример:
```bash
location / {
    try_files $uri $uri/ @back;
}
location @back {
    proxy_pass 127.0.0.1:8080;
}
```

### Варианты проксирования
  -  proxy_pass - HTTP proxy
  -  fastcgi_pass - FastCGI proxy (php)
  -  uwsgi_pass - UWSGI proxy (python)
  -  scgi_pass - SCGI proxy
  -  memcached_pass - memcached proxy (memcached)
  -  grpc_pass - GRPC proxy (grpc)

### Настройка проксирования HTTP

```bash 
location / {
    proxy_pass http://localhost:8000/uri/;
    proxy_pass http://unix:/tmp/backend.socket:/uri/;
    proxy_pass http://upstream;
    proxy_set_header Host $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Real-IP $remote_addr;
}
```

### Настройка балансировки (upstream)
```bash 
upstream backend {
    server backend1.example.com weight=5;
    server backend2.example.com:8080;
    server unix:/tmp/backend3;
    server backup1.example.com:8080 backup;
    server backup2.example.com:8080 backup;
}
server {
    location / {
    proxy_pass http://backend;
    }
}
```
### Параметры директивы server
  -  weight – вес сервера
  -  max_conns – максимальное количество одновременных
подключений
  -  backup – запасной сервер
  -  down – недоступный сервер
  -  max_fails – максимальное количество ошибок
  -  fail_timeout – время для определения недоступности
сервера (max_fails)

### Директива return
  -  Возврат кода ответа
  -  Перенаправление (301, 302)
  -  Примеры:
```bash
return (301 | 302 | 303 | 307) url;
return (1xx | 2xx | 4xx | 5xx) ["text"];
```
### Использование return
  -  На другой домен:
```bash 
server_name www.old.com old.com;
return 301 $scheme://www.new.com$request_uri;
```
  -  Исправление домена:
```bash
server {
    listen 80 default_server;
    listen 443 ssl default_server;
    server_name _;
    return 301 $scheme://www.example.com;
}
  -  Перенаправление на HTTPS:
```bash
return 301 https://example.com$request_uri;
```
### Директива rewrite
  -  Перенаправление на другой URL
  -  Синтаксис: rewrite regex URL [flag];
  -  Флаги:
     -  ○ last — завершаем обработку rewrite, ищем новый location
     -  ○ break — завершаем обработку rewrite, остаёмся в текущем location
     -  ○ redirect — возвращаем клиенту 302
     -  ○ permanent – возвращаем клиенту 301

### Использование rewrite
  -  Обычный rewrite:
```bash
rewrite ^/result/([a-zA-Z0-9_]+)$ /result/$1/ permanent;
```
  -  По GET-параметрам (/index?uid=425&doc=18 -> /users/425/documents/18)
```bash
location /index {
    if ($args ~ "^uid=(\d+)&doc=(\d+)") {
    set $key_uid $1;
    set $key_doc $2;
    rewrite ^.*$ /users/$key_uid/documents/$key_doc? last;
    } 
}
```
  -  Еще вариант (/index?uid=425&doc=18 -> /users/425/documents/18):
```bash
location /index {
    proxy_pass http://127.0.0.1:8080/users/$arg_uid/documents/$arg_doc
}
```
### Директива try_files
  -  Вариант последовательного перебора путей обработки запроса
  -  Пример:
```bash
location / {
    try_files /system/maintenance.html $uri $uri/index.html $uri.html @namedloc;
}
location @namedloc {
proxy_pass http://127.0.0.1:8080;
}
```
### Оптимизация доставки

#### Настройка gzip
```bash 
gzip on;
gzip_static on;
gzip_types text/plain text/css text/xml application/javascript
application/json application/msword application/rtf application/pdf
application/vnd.ms-excel image/x-icon image/svg+xml application/font-ttf;
gzip_comp_level 4;
gzip_proxied any;
gzip_min_length 1000;
gzip_disable "msie6";
gzip_vary on;
```
https://nginx.org/en/docs/http/ngx_http_gzip_module.html


#### Настройка brotli
```bash
brotli on;
brotli_static on;
brotli_comp_level 5;
brotli_types text/plain text/xml text/css application/javascript
application/json image/x-icon image/svg+xml;
```
https://github.com/google/ngx_brotli

#### Настройка zstd
```bash
zstd on;
zstd_min_length 256;
zstd_comp_level 5;
zstd_static on;
zstd_types text/plain text/css text/xml application/javascript
application/json image/x-icon image/svg+xml;
```
https://github.com/tokers/zstd-nginx-module
https://www.youtube.com/watch?v=lLThGyFPZIU

### Заголовки кэширования
```bash
location /static {
    add_header Cache-Control "max-age=31536000, public, no-transform, immutable";
}
```
### Серверное кэширование
nginx.conf:
```bash
proxy_cache_valid 1m;
proxy_cache_key $scheme$host$request_uri;
proxy_cache_path /cache levels=1:2 keys_zone=one:10m inactive=48h max_size=800m;
```
```bash
# Обязательно включить буферизацию ответа: proxy_buffering on
```
server.conf:
```bash
location / {
proxy_cache one;
proxy_cache_valid 200 1h;
proxy_cache_lock on;
proxy_cache_use_stale updating error timeout invalid_header http_500 http_502 http_504;
proxy_cache_background_update on;
}
```
http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_cache
http://nginx.org/en/docs/http/ngx_http_fastcgi_module.html#fastcgi_cache

### Настройка TLS
```bash
ssl_prefer_server_ciphers off;
ssl_protocols TLSv1.2 TLSv1.3;
ssl_ciphers
ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-S
HA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20
-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POL
Y1305;
ssl_early_data on;
ssl_session_tickets on;
ssl_session_timeout 28h;
ssl_session_cache shared:SSL:10m;
```
