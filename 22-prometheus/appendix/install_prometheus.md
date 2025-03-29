```bash 
# Устанавливаем вспомогательные пакеты и скачиваем Prometheus
$ yum update -y
$ yum install wget vim -y
$ wget https://github.com/prometheus/prometheus/releases/download/v2.44.0/prometheus-2.44.0.linux-amd64.tar.gz
```
```bash
# Создаем пользователя и нужные каталоги, настраиваем для них владельцев
$ useradd --no-create-home --shell /bin/false prometheus
$ mkdir /etc/prometheus
$ mkdir /var/lib/prometheus
$ chown prometheus:prometheus /etc/prometheus
$ chown prometheus:prometheus /var/lib/prometheus
```
```bash
# Распаковываем архив, для удобства переименовываем директорию и копируем бинарники в /usr/local/bin
$ tar -xvzf prometheus-2.44.0.linux-amd64.tar.gz
$ mv prometheus-2.44.0.linux-amd64 prometheuspackage
$ cp prometheuspackage/prometheus /usr/local/bin/
$ cp prometheuspackage/promtool /usr/local/bin/
# Меняем владельцев у бинарников
$ chown prometheus:prometheus /usr/local/bin/prometheus
$ chown prometheus:prometheus /usr/local/bin/promtool
```
```bash
# По аналогии копируем библиотеки
$ cp -r prometheuspackage/consoles /etc/prometheus
$ cp -r prometheuspackage/console_libraries /etc/prometheus
$ chown -R prometheus:prometheus /etc/prometheus/consoles
$ chown -R prometheus:prometheus /etc/prometheus/console_libraries
```
```bash
# Создаем файл конфигурации
$ vim /etc/prometheus/prometheus.yml
global:
 scrape_interval: 10s
scrape_configs:
 - job_name: 'prometheus_master'
 scrape_interval: 5s
 static_configs:
 - targets: ['localhost:9090']
$ chown prometheus:prometheus /etc/prometheus/prometheus.yml
```
```bash
# Настраиваем сервис
$ vim /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target
[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
--config.file /etc/prometheus/prometheus.yml \
--storage.tsdb.path /var/lib/prometheus/ \
--web.console.templates=/etc/prometheus/consoles \
--web.console.libraries=/etc/prometheus/console_libraries
[Install]
WantedBy=multi-user.target
$ systemctl daemon-reload
$ systemctl start prometheus
$ systemctl status prometheus
```