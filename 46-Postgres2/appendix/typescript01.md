# Less46. PostrgreSQL + Backup

## Проверка репликации

```bash
# Проверка репликации
# Список баз на сервере node2
postgres=# \l
                              List of databases
   Name    |  Owner   | Encoding | Collate |  Ctype  |   Access privileges   
-----------+----------+----------+---------+---------+-----------------------
 postgres  | postgres | UTF8     | C.UTF-8 | C.UTF-8 | 
 template0 | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
           |          |          |         |         | postgres=CTc/postgres
 template1 | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
           |          |          |         |         | postgres=CTc/postgres
(3 rows)

# Проверка репликации на хосте node1 
# Создадим базу 
postgres=# CREATE DATABASE otus_test;
CREATE DATABASE
postgres=# 

# Проверка репликации на хосте node2
# Список баз после репликации
postgres=# \l
                              List of databases
   Name    |  Owner   | Encoding | Collate |  Ctype  |   Access privileges   
-----------+----------+----------+---------+---------+-----------------------
 otus_test | postgres | UTF8     | C.UTF-8 | C.UTF-8 | 
 postgres  | postgres | UTF8     | C.UTF-8 | C.UTF-8 | 
 template0 | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
           |          |          |         |         | postgres=CTc/postgres
 template1 | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
           |          |          |         |         | postgres=CTc/postgres
(4 rows)

postgres=# 
postgres=# select * from pg_stat_wal_receiver;
  pid  |  status   | receive_start_lsn | receive_start_tli | written_lsn | flushed_lsn | received_tli |      last_msg_send_time       |     last_msg_receipt_time     | latest_end_lsn |        latest_end_time        | slot_name |  sender_host  | sender_port |                                                                                                                                         conninfo                                                                                                                                         
-------+-----------+-------------------+-------------------+-------------+-------------+--------------+-------------------------------+-------------------------------+----------------+-------------------------------+-----------+---------------+-------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 11644 | streaming | 0/3000000         |                 1 | 0/3000AF0   | 0/3000AF0   |            1 | 2025-07-06 22:38:01.535858-07 | 2025-07-06 22:38:01.573566-07 | 0/3000AF0      | 2025-07-06 22:37:01.408918-07 |           | 192.168.57.11 |        5432 | user=replication password=******** channel_binding=prefer dbname=replication host=192.168.57.11 port=5432 fallback_application_name=walreceiver sslmode=prefer sslcompression=0 sslsni=1 ssl_min_protocol_version=TLSv1.2 gssencmode=prefer krbsrvname=postgres target_session_attrs=any
(1 row)

(END)

```

## Проверка настроек 

```bash
# На хосте barman
# Проверка подключение к серверу и проверка настройки репликации
root@barman:~# psql -h 192.168.57.11 -U barman -c "IDENTIFY_SYSTEM" replication=1
Password for user barman: 
      systemid       | timeline |  xlogpos  | dbname 
---------------------+----------+-----------+--------
 7524201665308206011 |        1 | 0/C000148 | 
(1 row)

root@barman:~# barman switch-wal node1
The WAL file 00000001000000000000000C has been closed on server 'node1'

root@barman:~# barman cron 
Starting WAL archiving for server node1

root@barman:~# barman check node1
Server node1:
	PostgreSQL: OK
	superuser or standard user with backup privileges: OK
	PostgreSQL streaming: OK
	wal_level: OK
	replication slot: OK
	directories: OK
	retention policy settings: OK
	backup maximum age: FAILED (interval provided: 4 days, latest backup age: No available backups)
	backup minimum size: OK (0 B)
	wal maximum age: OK (no last_wal_maximum_age provided)
	wal size: OK (0 B)
	compression settings: OK
	failed backups: OK (there are 0 failed backups)
	minimum redundancy requirements: FAILED (have 0 backups, expected at least 1)
	pg_basebackup: OK
	pg_basebackup compatible: OK
	pg_basebackup supports tablespaces mapping: OK
	systemid coherence: OK (no system Id stored on disk)
	pg_receivexlog: OK
	pg_receivexlog compatible: OK
	receive-wal running: OK
	archiver errors: OK
root@barman:~# 

```
## Проверка восстановления кластера из бэкапа

```bash
# на сервере barman запускаем восстановление из бэкапа кластера node1
root@barman:~# barman list-backup node1
node1 20250707T072958 - Mon Jul  7 00:30:01 2025 - Size: 41.8 MiB - WAL Size: 0 B

root@barman:~# barman recover node1 20250707T072958 /var/lib/postgresql/14/main/ --remote-ssh-comman "ssh postgres@192.168.57.11"
The authenticity of host '192.168.57.11 (192.168.57.11)' can't be established.
ED25519 key fingerprint is SHA256:VqzuOCd91JsYs/ZOyOtNoKY/w+l+aBLITUXP+PdDRTU.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Starting remote restore for server node1 using backup 20250707T072958
Destination directory: /var/lib/postgresql/14/main/
Remote command: ssh postgres@192.168.57.11
Copying the base backup.
Copying required WAL segments.
Generating archive status files
Identify dangerous settings in destination directory.

WARNING
The following configuration files have not been saved during backup, hence they have not been restored.
You need to manually restore them in order to start the recovered PostgreSQL instance:

    postgresql.conf
    pg_hba.conf
    pg_ident.conf

Recovery completed (start time: 2025-07-07 07:33:45.857387, elapsed time: 15 seconds)

Your PostgreSQL server has been successfully prepared for recovery!
```
```bash
# на сервере node1 после перезапуска 

root@node1:~# systemctl restart postgresql
root@node1:~# su - postgres
postgres@node1:~$ psql
psql (14.18 (Ubuntu 14.18-0ubuntu0.22.04.1))
Type "help" for help.

postgres=# \l
                              List of databases
   Name    |  Owner   | Encoding | Collate |  Ctype  |   Access privileges   
-----------+----------+----------+---------+---------+-----------------------
 otus      | postgres | UTF8     | C.UTF-8 | C.UTF-8 | 
 otus_test | postgres | UTF8     | C.UTF-8 | C.UTF-8 | 
 postgres  | postgres | UTF8     | C.UTF-8 | C.UTF-8 | 
 template0 | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
           |          |          |         |         | postgres=CTc/postgres
 template1 | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
           |          |          |         |         | postgres=CTc/postgres
(5 rows)

postgres=# 

```
