# Less25. Основы сбора и хранения логов
- [Less25. Основы сбора и хранения логов](#less25-основы-сбора-и-хранения-логов)
    - [Цель:](#цель)
    - [Содержание:](#содержание)
    - [Результаты:](#результаты)
    - [Задание:](#задание)
    - [Формат сдачи:](#формат-сдачи)
    - [Критерии оценки:](#критерии-оценки)
    - [Компетенции:](#компетенции)
    - [Комментарии к выполнению задания:](#комментарии-к-выполнению-задания)
    - [Links:](#links)

### Цель: 
- понять зачем нужны логи и как их собирать;
- освоить принципы логирование с помощью rsyslog;
- понять возможности logrotate для задач ротации логов;
- научиться работать с journald и auditd;
- научится проектировать централизованный сбор логов;
- рассмотреть особенности разных платформ для сбора логов.
  
### Содержание:
- особенности и методы сбора и хранения логов;
- принципы работы rsyslog и logrotate;
- приемы работы и возможности journald;
- приемы работы с auditd;
### Результаты:
- полученные навыки по основам работы с rsyslog, logrotate, journald, auditd.
### Задание:
1. В Vagrant разворачиваем 2 виртуальные машины web и log
2. на web настраиваем nginx
3. на log настраиваем центральный лог сервер на любой системе на выбор
    • journald;
    • rsyslog;
    • elk.
4. настраиваем аудит, следящий за изменением конфигов nginx 

Все критичные логи с web должны собираться и локально и удаленно.
Все логи с nginx должны уходить на удаленный сервер (локально только критичные).
Логи аудита должны также уходить на удаленную систему.

> _Дополнительное задание:_
> - развернуть еще машину с elk
> - таким образом настроить 2 центральных лог системы elk и какую либо еще;
> - в elk должны уходить только логи Nginx;
> - во вторую систему все остальное.

### Формат сдачи: 
- Vagrantfile + ansible

### Критерии оценки:
- Статус "Принято" ставится, если присылаете логи скриншоты без вагранта.
- Задание со звездочкой выполняется по желанию.
### Компетенции:
Обеспечение стабильности
- работать с базовыми инструментами сбора логов: rsyslog, logrotate
- разбираться в причинах некорректной работы системы, анализировать потребление ресурсов, производить аудит, интерпретировать логи
  
### Комментарии к выполнению задания:

> _Задание выполнено c использованием Vagrant, libvirt, vagrant box cloud-image/ubuntu-22.04 версия 20240823.0.0_

1. [Vagrentfile](./Vagrantfile) - три виртуальные машины (web, simple, log)
2. [ansible-playbook](./ansible/provision.yml) 
- на сервере web устанавливает nginx, редактирует конфигурационный файл для отправки логов на сервер log; 
  - _файл конфигурации /etc/nginx/[nginx.conf](./files/hosts/web/nginx.conf)_
- на хосте simple создает конфигурацию в rsyslog для отправки всех логов на сервер log; 
  - _файл конфигурации /etc/rsyslog.d/[all.conf](./files/hosts/simple/rsyslog/all.conf)_
- на сервере log выполняет настройки для принятия логов; 
  - файл конфигурации /etc/[rsyslog.conf](./files/hosts/log/rsyslog.conf)

1. Проверка получения логов:
```bash
# Проверяем логи от nginx на сервере log
# успешные сессии
root@log:~# cat /var/log/rsyslog/web/nginx_access.log
Apr 18 15:58:46 web nginx_access: 192.168.56.1 - - [18/Apr/2025:15:58:46 +0000] "GET / HTTP/1.1" 200 396 "-" "Mozilla/5.0 (X11; Linux x86_64; rv:137.0) Gecko/20100101 Firefox/137.0"
Apr 18 15:58:46 web nginx_access: 192.168.56.1 - - [18/Apr/2025:15:58:46 +0000] "GET /favicon.ico HTTP/1.1" 404 134 "http://192.168.56.10/" "Mozilla/5.0 (X11; Linux x86_64; rv:137.0) Gecko/20100101 Firefox/137.0"
Apr 18 15:58:49 web nginx_access: 192.168.56.1 - - [18/Apr/2025:15:58:49 +0000] "GET / HTTP/1.1" 304 0 "-" "Mozilla/5.0 (X11; Linux x86_64; rv:137.0) Gecko/20100101 Firefox/137.0"
Apr 18 15:58:50 web nginx_access: 192.168.56.1 - - [18/Apr/2025:15:58:50 +0000] "GET / HTTP/1.1" 304 0 "-" "Mozilla/5.0 (X11; Linux x86_64; rv:137.0) Gecko/20100101 Firefox/137.0"
Apr 18 15:58:50 web nginx_access: message repeated 2 times: [ 192.168.56.1 - - [18/Apr/2025:15:58:50 +0000] "GET / HTTP/1.1" 304 0 "-" "Mozilla/5.0 (X11; Linux x86_64; rv:137.0) Gecko/20100101 Firefox/137.0"]
Apr 18 15:58:51 web nginx_access: 192.168.56.1 - - [18/Apr/2025:15:58:51 +0000] "GET / HTTP/1.1" 304 0 "-" "Mozilla/5.0 (X11; Linux x86_64; rv:137.0) Gecko/20100101 Firefox/137.0"
# неуспешные сессии
root@log:~# cat /var/log/rsyslog/web/nginx_error.log
Apr 18 16:04:31 web nginx_error: 2025/04/18 16:04:31 [error] 7808#7808: *2 directory index of "/var/www/html/" is forbidden, client: 192.168.56.1, server: _, request: "GET / HTTP/1.1", host: "192.168.56.10"
Apr 18 16:04:34 web nginx_error: 2025/04/18 16:04:34 [error] 7808#7808: *2 directory index of "/var/www/html/" is forbidden, client: 192.168.56.1, server: _, request: "GET / HTTP/1.1", host: "192.168.56.10"
Apr 18 16:04:35 web nginx_error: 2025/04/18 16:04:35 [error] 7808#7808: *2 directory index of "/var/www/html/" is forbidden, client: 192.168.56.1, server: _, request: "GET / HTTP/1.1", host: "192.168.56.10"
Apr 18 16:04:35 web nginx_error: 2025/04/18 16:04:35 [error] 7808#7808: *2 directory index of "/var/www/html/" is forbidden, client: 192.168.56.1, server: _, request: "GET / HTTP/1.1", host: "192.168.56.10"
root@log:~# 
```

```bash
# На хосте simple настроена передача всех логов на сервер log:
root@log:~# ls -la /var/log/rsyslog/simple/
total 16
drwxr-xr-x 2 syslog syslog 4096 Apr 19 21:33 .
drwxr-xr-x 5 syslog syslog 4096 Apr 19 21:33 ..
-rw-r----- 1 syslog adm     547 Apr 19 21:33 rsyslogd.log
-rw-r----- 1 syslog adm     352 Apr 19 21:33 systemd.log
root@log:~# 
root@log:~# cat /var/log/rsyslog/simple/systemd.log 
Apr 19 21:33:23 simple systemd[1]: Stopping System Logging Service...
Apr 19 21:33:23 simple systemd[1]: rsyslog.service: Deactivated successfully.
Apr 19 21:33:23 simple systemd[1]: Stopped System Logging Service.
Apr 19 21:33:23 simple systemd[1]: Starting System Logging Service...
Apr 19 21:33:23 simple systemd[1]: Started System Logging Service.
root@log:~# 
```

### Links:

- [Лекционный материал](./appendix/commandset.md)
- --
- [Настройка rsyslog для хранения логов на удаленном сервере](https://www.dmosk.ru/miniinstruktions.php?mini=rsyslog)
- [Elasticsearch + Kibana + Logstash на Ubuntu](https://www.dmosk.ru/instruktions.php?object=elk-ubuntu#clients-install-ubuntu)
- [Директивы в nginx](https://nginx.org/ru/docs/ngx_core_module.html#error_log)

---
- [https://en.wikipedia.org/wiki/Syslog](https://en.wikipedia.org/wiki/Syslog)
- [https://wiki.archlinux.org/title/Systemd/Journal](https://wiki.archlinux.org/title/Systemd/Journal)

---
- [https://www.shellhacks.com/ansible-comment-out-uncomment-lines-in-a-file/](https://www.shellhacks.com/ansible-comment-out-uncomment-lines-in-a-file/)
- [https://stackoverflow.com/questions/42001251/ansible-uncomment-line-in-file](https://stackoverflow.com/questions/42001251/ansible-uncomment-line-in-file)
- 