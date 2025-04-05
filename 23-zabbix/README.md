# Less23. Zabbix
- [Less23. Zabbix](#less23-zabbix)
    - [Цель:](#цель)
    - [Содержание](#содержание)
    - [Задание:](#задание)
    - [Критерии оценки:](#критерии-оценки)
    - [Компетенции:](#компетенции)
    - [Комментарии к выполнению задания:](#комментарии-к-выполнению-задания)
    - [Links:](#links)

### Цель: 
- развернуть "песочницу” с Zabbix;
- администрировать Zabbiх;
- настраивать автообнаружение;
- настраивать уведомления об авариях;
  
### Содержание
- архитектура системы мониторинга Zabbix;
- обзор базовой конфигурации системы;
- основные настройки (items, triggers, templates) Discovery и Actions
### Задание:

### Критерии оценки:

### Компетенции:
Обеспечение стабильности
   - разбираться в причинах некорректной работы системы, анализировать потребление ресурсов, производить аудит, интерпретировать логи
   - настраивать внешний мониторинг системы и сигнализацию в случае некорректного поведения системы
  
### Комментарии к выполнению задания:

1. Список node в Prometheus [screnshot1](./files/screenshot-prometheus_node_list.png).
2. Скриншот с Grafana со списком node (использован шаблон дашборда из репозитория Grafana) [screenshot2](./files/screenshot-grafana_nodes.png)
3. Скриншот дашборда с метриками памяти, процессора, диска и сети [screenshot3](./files/screenshot-grafana_my_dashboard.png)
4. Файл конфигурации Prometheus [prometheus.yml](./files/prometheus.yml)

### Links:

- [prometheus.io ](https://prometheus.io/)
- [https://www.yamllint.com/](https://www.yamllint.com/)
- https://grafana.com/grafana/dashboard
- [https://jsonnet.org/](https://jsonnet.org/)
  