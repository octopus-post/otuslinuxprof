# Установка Node Exporter 
```bash
# Скачиваем и распаковываем Node Exporter
$ wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
$ tar xzfv node_exporter-1.5.0.linux-amd64.tar.gz
```
```bash
# Создаем пользователя, перемещаем бинарник в /usr/local/bin
$ useradd -rs /bin/false nodeusr
$ mv node_exporter-1.5.0.linux-amd64/node_exporter /usr/local/bin/
```
```bash
# Создаем сервис
$ vim /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network.target
[Service]
User=nodeusr
Group=nodeusr
Type=simple
ExecStart=/usr/local/bin/node_exporter
[Install]
WantedBy=multi-user.target
```
```bash
# Запускаем сервис
$ systemctl daemon-reload
$ systemctl start node_exporter
$ systemctl enable node_exporter
```
```yaml
# Обновляем конфигурацию Prometheus
$ vim /etc/prometheus/prometheus.yml
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
# Перезапускаем сервис
$ systemctl restart prometheus
```