# Less36. DNS - настройка и обслуживание
- [Less36. DNS - настройка и обслуживание](#less36-dns---настройка-и-обслуживание)
    - [Цель:](#цель)
    - [Содержание:](#содержание)
    - [Результаты:](#результаты)
    - [Компетенции](#компетенции)
    - [Задание:](#задание)
    - [Формат сдачи:](#формат-сдачи)
    - [Критерии оценки:](#критерии-оценки)
    - [Комментарии к выполнению задания:](#комментарии-к-выполнению-задания)
      - [1. Работа со стендом и настройка DNS](#1-работа-со-стендом-и-настройка-dns)
      - [2. Настройка Split-DNS](#2-настройка-split-dns)
    - [Links:](#links)

### Цель: 
- узнать как завести домен;
- управлять зонами (bind/powerdns);
- обслуживать свой домен самостоятельно;
- разобрать dig/host/nslookup.
  
### Содержание:
- DNS;
- терминология;
- типы серверов;
- типы записей;
- зона;
- PTR;
- репликация;
- SplitDNS.

практическая работа: настраиваем свой кеширующий днс (мастер/слейв) со своей локальной зоной.
 
### Результаты:
- приобретать и настраивать домены, смогут запустить собственный DNS сервер.

### Компетенции

Работа с сетевой подсистемой
- управлять и настраивать DNS сервера
 
### Задание:
Что нужно сделать?

- взять стенд https://github.com/erlong15/vagrant-bind
- добавить еще один сервер client2
- завести в зоне dns.lab
- имена
- web1 - смотрит на клиент1
- web2 смотрит на клиент2
- завести еще одну зону newdns.lab
- завести в ней запись
- www - смотрит на обоих клиентов
- настроить split-dns
- клиент1 - видит обе зоны, но в зоне dns.lab только web1
- клиент2 видит только dns.lab
    
    настроить все без выключения selinux*


### Формат сдачи: 
Формат сдачи ДЗ - vagrant + ansible

### Критерии оценки:
Статус «Принято» ставится при выполнении следующих условий:
1. Сcылка на репозиторий GitHub.
2. Vagrantfile, который будет разворачивать виртуальные машины
3. Настройка виртуальных машин происходит с помощью Ansible.
4. Документация по каждому заданию:
Создайте файл README.md и снабдите его следующей информацией:
- название выполняемого задания;
- текст задания;
- схема сети;
- особенности проектирования и реализации решения, 
- заметки, если считаете, что имеет смысл их зафиксировать в
репозитории.

### Комментарии к выполнению задания:
> _Задание выполнено с использованием:_
> - Vagrant 2.4.5
> - Virtualbox 7.1.8 r168469
> - vagrant box: ubuntu/jammy64
> - Ansible [core 2.18.5]

  - файл Vagrant [./vagrant36/Vagrantfile](./vagrant36/Vagrantfile)
  - ansible playbook [./vagrant36/ansible/playbook.yml](./vagrant36/ansible/playbook.yml)
  - inventory [./vagrant36/ansible/hosts](./vagrant36/ansible/hosts)
  - каталог шаблонов [./vagrant36/ansible/provisioning/](./vagrant36/ansible/provisioning/)

#### 1. Работа со стендом и настройка DNS

Результат запуска стенда с настроенными dns-серверами [commandset.md#1-работа-со-стендом-и-настройка-dns](./appendix/commandset.md#1-работа-со-стендом-и-настройка-dns)

 - _на сервере ns02 для успешного получения реплики зон с мастера в конфиге в параметре directory указан каталог /var/cache/bind_

#### 2. Настройка Split-DNS 
Результат настройки стенда split-dns [commandset.md#2-настройка-split-dns](./appendix/commandset.md#2-настройка-split-dns)

  - _NB! На сервере ns01 не проходит проверку конфиг /named.conf.options до тех пор, пока в последнем view есть зона newdns.lab. Причина не понятна, пока зона закомментирована в конфиге /etc/bind/named.conf.options_
```bash
root@ns01:~# named-checkconf /etc/bind/named.conf
/etc/bind/named.conf.options:149: writeable file '/etc/bind/named.newdns.lab': already in use: /etc/bind/named.conf.options:84
```


### Links:

- [commandset.md](./appendix/commandset.md)
- [Статья o DNS (общая информация)](https://ru.wikipedia.org/wiki/DNS )
- [Статья «DNS сервер BIND (теория)»](https://habr.com/ru/post/137587/)
- [Статья «Настройка Split DNS на одном сервере Bind»](https://www.dmosk.ru/miniinstruktions.php?mini=split-dns-bind)
- [Статья «Split DNS: заставим BIND работать на два фронта!»](http://samag.ru/archive/article/771)
- [Статья «DNS BIND Zone Transfers and Updates»](https://www.zytrax.com/books/dns/ch7/xfer.html#:~:text=also%2Dnotify%20Statement%20(Pre%20BIND9.9)&text=also%2Dnotify%20defines%20a%20list,NS%20records%20for%20the%20zone)
