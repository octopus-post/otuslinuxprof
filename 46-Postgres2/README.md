# Less46. Postgres: Backup + Репликация  
- [Less46. Postgres: Backup + Репликация](#less46-postgres-backup--репликация)
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
- создавать резервные копий;
- настраивать репликации;
  
### Содержание:
- создание резервных копий с помощью Barman;
- настройка потоковой репликации Master-Slave;
 
### Результаты:
- научиться разбираться в терминологии различных технологий VPN и смогут поднять свой собственный VPN сервер.

### Компетенции

Настройка базовых сервисов ОС Linux
  - применять базовые навыки администрирования Postgres: архитектура, установка, конфигурация, бэкап и репликация
 
### Задание:
Репликация postgres
- Научиться настраивать репликацию и создавать резервные копии в СУБД PostgreSQL;

Что нужно сделать?

    настроить hot_standby репликацию с использованием слотов
    настроить правильное резервное копирование

### Формат сдачи: 
Формат сдачи ДЗ - vagrant + ansible

### Критерии оценки:
Статус «Принято» ставится при выполнении следующих условий:

    Сcылка на репозиторий GitHub.
    Vagrantfile, который будет разворачивать виртуальные машины
    Плейбук Ansible
    Конфигурационные файлы postgresql.conf, pg_hba.conf и recovery.conf,
    Конфиг barman, либо скрипт резервного копирования.
    Документация по каждому заданию:
    Создайте файл README.md и снабдите его следующей информацией:

    название выполняемого задания;
    текст задания;
    описание команд и их вывод;
    особенности проектирования и реализации решения,
    заметки, если считаете, что имеет смысл их зафиксировать в репозитории.

### Комментарии к выполнению задания:
> _Задание выполнено с использованием:_
> - Vagrant 2.4.5
> - Virtualbox 7.1.8 r168469
> - vagrant box: ubuntu/jammy64
> - Ansible [core 2.18.5]

- Vagranfile [./vagrant46/Vagrantfile](./vagrant46/Vagrantfile)
- Ansible-playbook [./vagrant46/ansible/provision.yml](./vagrant46/ansible/provision.yml)
- Файлы шаблонов конфигурации postgresql [./vagrant46/ansible/postgres_replication/templates/](./vagrant46/ansible/postgres_replication/templates/)
- Файлы шаблонов конфигурации barman [./vagrant46/ansible/install_barman/templates/](./vagrant46/ansible/install_barman/templates/)
- Файл конфигураций [./files/](./files/)
- Вывод команд и проверка результатов [](./appendix/typescript01.md)

- Материалы лекционного занятия 
    - [../45-PostgreSQL/appendix/commandset.md](../45-PostgreSQL/appendix/commandset.md)
    - [commandset.md](./appendix/commandset.md)

### Links:

- https://github.com/Demonware/postgresql/blob/master/Vagrantfile
- • Статья «Настройка потоковой репликации PostgreSQL» - https://www.dmosk.ru/miniinstruktions.php?mini=postgresql-replication
-    • Статья «Настройка streaming Master-Slave репликации в PosgtreSQL 12 и мониторинг» - https://it-lux.ru/streaming-replication-master-slave-posgtresql-12/ 
-    • Статья «Barman. менеджер бэкапов для серверов PostgreSQL» - https://sidmid.ru/barman-%D0%BC%D0%B5%D0%BD%D0%B5%D0%B4%D0%B6%D0%B5%D1%80-%D0%B1%D1%8D%D0%BA%D0%B0%D0%BF%D0%BE%D0%B2-%D0%B4%D0%BB%D1%8F-%D1%81%D0%B5%D1%80%D0%B2%D0%B5%D1%80%D0%BE%D0%B2-postgresql/
-    • Статья «Implement backup with Barman» - https://medium.com/@kiwiv/implement-backup-with-barman-bb0b44af71f9 
-    • Статья о простых операциях с данными в Postgres - https://metanit.com/sql/postgresql/3.1.php 
-    • Официальная документация Barman - https://docs.pgbarman.org/release/3.1.0/#introduction
-    • Статья «The password file» - https://www.postgresql.org/docs/current/libpq-pgpass.html
-    • Статья Roles in Ansible - https://docs.ansible.com/ansible/2.9/user_guide/playbooks_reuse_roles.html
