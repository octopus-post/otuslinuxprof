# Сбор и анализ логов: ELK

## Стек ELK
**ELK** - это аббревиатура из названий продуктов, которые входят в стек:
- Elasticsearch - NoSQL база данных
- Logstash - приложение для сбора и обработки данных с
возможностью конвейерной обработки
- Kibana - графический интерфейс для удобства работы с базой
Elasticsearch

### Beats: Data shippers
Beats - это поставщики данных для обработки в стеке ELK

link: [https://www.elastic.co/beats/](https://www.elastic.co/beats/)

Основные поставщики:
- Filebeat
- Heartbeat
- Auditbeat
- Metricbeat
- Packetbeat
- Winlogbeat

### Beats: Filebeat
Filebeat - основной поставщик данных в ELK

Особенности:
- Большое количество вариантов ввода данных
(files, syslog, stdin, docker, json, MQTT, netflow)
- Возможность базовой фильтрации и модификации сообщений
- Возможность вывода в Logstash или в базу Elasticsearch напрямую

### Beats: Heartbeat
Heartbeat - устанавливается на удаленный сервер и проводит периодические проверки
сервисов

Особенности:
- Умеет пинговать по ICMP, TCP и HTTP
- Поддерживает TLS, аутентификацию и прокси
- Может мониторить не только внутренние, но и внешние ресурсы
- Поддерживает возможность вывода в Logstash или в базу Elasticsearch

### Beats: Auditbeat
Auditbeat - собирает и передает события публикуемые Linux Audit Framework (auditd)

Особенности:
- Сбор событий безопасности сервера
- Сбор любых кастомных событий сервера
- Поддерживает возможность вывода в Logstash или в базу Elasticsearch

### Beats: Metricbeat
Metricbeat - собирает и передает метрики с сервера и сервисов, которые запущены на
этом сервере

Особенности:
- Сбор метрик по подсистемам сервера (CPU, память, диски, сеть)
- Сбор метрик распространенных сервисов (apache, nginx, mysql, docker, kubernetes)
- Поддерживает возможность вывода в Logstash или в базу Elasticsearch

_Пример конфигурации Filebeat_

_Конфигурация вывода и передачи сообщений_

_Проверка конфигурации_
```bash 
filebeat test config
```

### Beats: Data shippers

![Data shippers](Сбор%20и%20анализ%20логов%20-%20Part%202%20ELK_Data%20shippers.png)


### Logstash
Приложение для сбора и обработки данных с возможностью конвейерной обработки

link: [https://grokdebugger.com/](https://grokdebugger.com/)

Особенности:
- Большой выбор входящих источников данных
- Большой выбор исходящих потоков данных
- Кастомные фильтры в формате JSON

_Конфигурация входных данных logstash:_


_Конфигурация фильтра обработки логов syslog выходного потока logstash_

_Конфигурация выходного потока logstash:_

_Конфигурация logstash_

```bash
# Проверка синтаксиса конфигов logstash
/usr/share/logstash/bin/logstash -t -f /etc/logstash/conf.d/
# Автоматический релоад конфигурации logstash без рестарта сервиса:

```

_Возможные варианты плагинов вывода данных logstash:_
[https://www.elastic.co/guide/en/logstash](https://www.elastic.co/guide/en/logstash)


## Elasticsearch
Elasticsearch – база данных, построенная на движке Apache Lucene, изначально
адаптированная под полнотекстовый поиск

Особенности:
- Быстрая индексация
- Производительный полнотекстовый поиск
- Масштабируемая
- Удобная репликация и шардирование

```bash
# Проверка работы базы данных:
curl -GET https://localhost:9200/_cat/health?v
#Просмотр индексов в базе:
curl -GET https://localhost:9200/_cat/indices?v
```

## Kibana
Kibana – графический интерфейс для удобства работы с базой Elasticsearch

Особенности:
- Анализ данных в индексах Elasticsearch
- Гибкое отображение данных с помощью фильтров
- Широкие возможности визуализации данных (графики, дашборды)
- Мониторинг
- Управление индексами

_Автоматическая очистка индексов в elasticsearch_

## Практика
1:00
### Установка Elasticsearch
```bash
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
apt install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | tee -a
/etc/apt/sources.list.d/elastic-8.x.list
apt update && apt install elasticsearch
—-------------------------------------------------------
Reset the password of the elastic built-in superuser with
'/usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic'.
Generate an enrollment token for Kibana instances with
'/usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana'.
Generate an enrollment token for Elasticsearch nodes with
'/usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s node'.
```

### Установка Kibana
```bash
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
apt install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | tee -a
/etc/apt/sources.list.d/elastic-8.x.list
apt install kibana
systemctl daemon-reload
systemctl enable kibana.service
systemctl start kibana.service
/usr/share/elasticsearch/bin/elasticsearch-reset-password -u kibana_system
cp -R /etc/elasticsearch/certs /etc/kibana
chown -R root:kibana /etc/kibana/certs
```

### Установка Logstash
```bash
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
apt install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | tee -a
/etc/apt/sources.list.d/elastic-8.x.list
apt install logstash
systemctl enable logstash.service
cp -R /etc/elasticsearch/certs /etc/logstash
chown -R root:logstash /etc/logstash/certs
```

Альтернативы:
loki + prometheus + grafana
opensearch

