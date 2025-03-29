# Установка AlertManager
```bash
# Скачиваем и распаковываем AlertManager
$ wget https://github.com/prometheus/alertmanager/releases/download/v0.25.0/alertmanager-0.25.0.linux-amd64.tar.gz
$ tar zxf alertmanager-0.25.0.linux-amd64.tar.gz
```
```bash
# Создаем пользователя и нужные директории
$ useradd --no-create-home --shell /bin/false alertmanager
$ usermod --home /var/lib/alertmanager alertmanager
$ mkdir /etc/alertmanager
$ mkdir /var/lib/alertmanager
```
```bash
# Копируем бинарники из архива в /usr/local/bin и меняем владельца
$ cp alertmanager-0.25.0.linux-amd64/amtool /usr/local/bin/
$ cp alertmanager-0.25.0.linux-amd64/alertmanager /usr/local/bin/
$ cp alertmanager-0.25.0.linux-amd64/alertmanager.yml /etc/alertmanager/
$ chown -R alertmanager:alertmanager /etc/alertmanager /var/lib/alertmanager
$ chown alertmanager:alertmanager /usr/local/bin/{alertmanager,amtool}
$ echo "ALERTMANAGER_OPTS=\"\"" > /etc/default/alertmanager
$ chown alertmanager:alertmanager /etc/default/alertmanager
$ chown -R alertmanager:alertmanager /var/lib/prometheus/alertmanager
```
```bash
# Настраиваем сервис
$ vim /etc/systemd/system/alertmanager.service
[Unit]
Description=Alertmanager Service
After=network.target prometheus.service
[Service]
EnvironmentFile=-/etc/default/alertmanager
User=alertmanager
Group=alertmanager
Type=simple
ExecStart=/usr/local/bin/alertmanager \
 --config.file=/etc/alertmanager/alertmanager.yml \
 --storage.path=/var/lib/prometheus/alertmanager \
 $ALERTMANAGER_OPTS
ExecReload=/bin/kill -HUP $MAINPID
Restart=on-failure
Restart=always
[Install]
WantedBy=multi-user.target
# Запускаем сервис
$ systemctl daemon-reload
$ systemctl start alertmanager
```
```bash
# Настраиваем правила
$ vim /etc/prometheus/rules.yml
---
groups:
- name: alert.rules
 rules:
 - alert: InstanceDown
   expr: up == 0
   for: 1m
   labels:
     severity: critical
   annotations:
     description: '{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 1 minute.'
     summary: Instance {{ $labels.instance }} down
# Проверяем валидность
$ /usr/local/bin/promtool check rules /etc/prometheus/rules.yml
```
```bash
# Обновляем конфиг prometheus
$ vim /etc/prometheus/prometheus.yml
---
global:
  scrape_interval: 10s
scrape_configs:
  - job_name: 'prometheus_master'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'node_exporter_centos'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9100']

rule_files:
  - "rules.yml"
alerting:
  alertmanagers:
    - static_configs:
    - targets:
    - localhost:9093
# Рестартуем сервисы
$ systemctl restart prometheus
$ systemctl restart alertmanager
```