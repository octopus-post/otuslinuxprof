# Less44. MySQL: Backup + Репликация
- [Less44. MySQL: Backup + Репликация](#less44-mysql-backup--репликация)
    - [Цель:](#цель)
    - [Содержание:](#содержание)
    - [Результаты:](#результаты)
    - [Компетенции](#компетенции)
    - [Задание:](#задание)
    - [Формат сдачи:](#формат-сдачи)
    - [Критерии оценки:](#критерии-оценки)
    - [Комментарии к выполнению задания:](#комментарии-к-выполнению-задания)
    - [Links:](#links)

### Цель: 
- снимать резервные копии;
- восстанавливать базу после сбоя;
- настраивать master-slave репликацию.
  
### Содержание:
- задачи резервного копирования;
- уровни резервного копирования;
- вопросы для планирования РК;
- конфигурация;
- репликация;
- backup;
 
### Результаты:
- 
### Компетенции

Настройка базовых сервисов ОС Linux
  - применять базовые навыки администрирования Mysql: архитектура, установка, конфигурация, бэкап и репликация

### Задание:
-
Что нужно сделать?

1) В материалах приложены ссылки на вагрант для репликации и дамп базы bet.dmp
2) Базу развернуть на мастере и настроить так, чтобы реплицировались таблицы:

| bookmaker          |
| competition        |
 market              |
| odds               |
| outcome

3) Настроить GTID репликацию

варианты которые принимаются к сдаче
  -  рабочий вагрантафайл
  -  скрины или логи SHOW TABLES
  -  конфиги*

пример в логе изменения строки и появления строки на реплике*

### Формат сдачи: 

### Критерии оценки:

### Комментарии к выполнению задания:
> _Задание выполнено с использованием:_
> - Vagrant 2.4.5
> - Virtualbox 7.1.8 r168469
> - vagrant box: bento/ubuntu-22.04
> - Ansible [core 2.18.5]

- Vagrantfile [Vagrantfile](./vagrant-mysql-repl/Vagrantfile)
- ansible-playbook [./vagrant-mysql-repl/provision/](./vagrant-mysql-repl/provision/)
- файлы конфигураций mysql-серверов SOURCE (mysql1) и REPLICA (mysql2) [./files/](./files/)
- файлы бэкапов [./files/mysql_dump/](./files/mysql_dump/)

Материалы занятия:
[commandset.md](./appendix/commandset.md)

> NB! Разобраться, почему на сервере REPLICA в статусе в параметре _Replicate_Ignore_Table_ нет списка игнорируемых таблиц:
> - bet.events_on_demand,bet.v_same_event, хотя они не реплицируются

### Links:

- https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html
- https://docs.percona.com/percona-xtrabackup/8.0/create-full-backup.html
- https://docs.percona.com/percona-xtrabackup/8.0/create-compressed-backup.html
- https://docs.percona.com/percona-xtrabackup/8.0/restore-a-backup.html
- https://docs.percona.com/percona-xtrabackup/8.0/restore-individual-partitions.html
- https://docs.percona.com/percona-xtrabackup/8.0/create-partial-backup.html
====
- https://docs.percona.com/percona-xtrabackup/8.0/docker.html
- https://hub.docker.com/r/percona/percona-xtrabackup
====
- https://dev.mysql.com/doc/refman/8.0/en/replica-logs-relaylog.html

- https://dev.mysql.com/doc/refman/8.0/en/group-replication-summary.html
- https://dev.mysql.com/doc/refman/8.0/en/replication-sbr-rbr.html
- https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html
- https://dev.mysql.com/doc/refman/8.0/en/change-replication-filter.html

====

> Список материалов для изучения
1. https://docs.aws.amazon.com/whitepapers/latest/amazon-aurora-mysql-migration-handbook/multi-threaded-migration-using-mydumper-and-myloader.html
2. https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html
3. https://github.com/mydumper/mydumper
4. https://docs.percona.com/percona-xtrabackup/8.0/create-full-backup.html
5. https://dev.mysql.com/doc/refman/8.0/en/change-replication-filter.html
6. https://www.percona.com/blog/backup-and-restore-with-mydumper-on-docker/
7. https://github.com/Nickmob/vagrant-mysql-repl
