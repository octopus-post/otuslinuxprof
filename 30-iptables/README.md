# Less30. Фильтрация трафика - iptables
- [Less30. Фильтрация трафика - iptables](#less30-фильтрация-трафика---iptables)
    - [Цель:](#цель)
    - [Содержание:](#содержание)
    - [Результаты:](#результаты)
    - [Компетенции](#компетенции)
    - [Задание:](#задание)
    - [Формат сдачи:](#формат-сдачи)
    - [Критерии оценки:](#критерии-оценки)
    - [Комментарии к выполнению задания:](#комментарии-к-выполнению-задания)
      - [1. knocking port](#1-knocking-port)
      - [2. FORWARD](#2-forward)
    - [Links:](#links)

### Цель: 
- понимать путь прохождения пакетов;
- настраивать базовые правила фильтрации;
- настраивать наборы правил через ipset;
  
### Содержание:
- подсистема netfilter;
- цепочки и таблицы;
- синтаксис iptables;
- использование IPset
 
### Результаты:
- настроенный сетевой фильтр
### Компетенции

Работа с сетевой подсистемой
- обеспечивать сетевую безопасность
- 
### Задание:

Написать сценарии iptables.
Что нужно сделать?

- реализовать knocking port
- centralRouter может попасть на ssh inetRouter через knock скрипт (пример в материалах.)
- добавить inetRouter2, который виден(маршрутизируется (host-only тип сети для виртуалки)) с хоста или форвардится порт через локалхост.
- запустить nginx на centralServer.
- пробросить 80й порт на inetRouter2 8080.
- дефолт в инет оставить через inetRouter.

Реализовать проход на 80й порт без маскарадинга*

### Формат сдачи: 
Формат сдачи ДЗ - vagrant + ansible


### Критерии оценки:
Статус "Принято" ставится при выполнении всех основных условий.

Задание со звездочкой выполняется по желанию.

### Комментарии к выполнению задания:
> _Задание выполнено с использованием:_
> - Vagrant 2.4.5
> - Virtualbox 7.1.8 r168469
> - vagrant box: bento/ubuntu-22.04
> - Ansible [core 2.18.5]

#### 1. knocking port
*материалы для подготовки [port_knocking.md](./appendix/port_knocking.md)*

- файл конфигурации демона [knockd.conf.j2](./vagrant30/ansible/templates/knockd.conf.j2)
- файл параметрами запуска демона [knockd.j2](./vagrant30/ansible/templates/knockd.j2)
- установка, настройка и запуск демона выполнены в плейбуке ansible [provision.yml](./vagrant30/ansible/provision.yml)
- для проверки работы демона предварительно из iptables удалить правило, разрешающее новые соединения по порту 22:
```bash 
iptables -D INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT
```
- на сервере inetRouter демон слушает интерфейс enp0s8
- на сервере centralRouter запустить следовательности соединений на порты 7000, 8000, 9000 
```bash
vagrant@centralRouter:~$ knock 192.168.255.1 7000 8000 9000
```
- на сервере inetRouter демон открывает для узла 192.168.255.2 порт 22 на 10 сек.:
  
```bash
-A INPUT -s 192.168.255.2/32 -p tcp -m tcp --dport 22 -j ACCEPT
```
- далее правило удаляется, но соединение не разрывается при наличии в iptables правила:
  
```bash
-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
``` 

```bash 
# список правил iptables
vagrant@inetRouter:~$ sudo iptables-save
# Generated by iptables-save v1.8.7 on Wed May 21 16:00:21 2025
*filter
:INPUT DROP [32:2388]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [3759:426655]
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A INPUT -s 192.168.255.2/32 -p tcp -m tcp --dport 22 -j ACCEPT
-A FORWARD -i enp0s8 -j ACCEPT
-A FORWARD -o enp0s8 -j ACCEPT
-A FORWARD -i enp0s10 -j ACCEPT
-A FORWARD -o enp0s10 -j ACCEPT
COMMIT
# Completed on Wed May 21 16:00:21 2025
# Generated by iptables-save v1.8.7 on Wed May 21 16:00:21 2025
*nat
:PREROUTING ACCEPT [214:25889]
:INPUT ACCEPT [126:12707]
:OUTPUT ACCEPT [49:6044]
:POSTROUTING ACCEPT [40:5376]
-A POSTROUTING ! -d 192.168.0.0/16 -o enp0s10 -j MASQUERADE
COMMIT
# Completed on Wed May 21 16:00:21 2025
```
#### 2. FORWARD
- на сервере centralServer запущен nginx
- на inetRouter2 настроен проброс порта 80 до веб-сервера (правила iptables - файл [iptables_rules_inetRouter2.ipv4](./vagrant30_2/ansible/templates/iptables_rules_inetRouter2.ipv4))
- на всех серверах доступ в интернет остаётся через inetRouter

```bash 
 # проверка доступности сервера nginx c хостовой машины
  ╭─alex@smith in repo: otuslinuxprof/30-iptables/vagrant30 on  main [!?] via ⍱ v2.4.5 took 2m12s
[🔴] × curl 192.168.0.3:8080
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

```bash
# просмотр обращений к серверу по результатам conntrack
vagrant@inetRouter2:~$ sudo conntrack -E
    [NEW] tcp      6 120 SYN_SENT src=192.168.0.1 dst=192.168.0.3 sport=47442 dport=8080 [UNREPLIED] src=192.168.0.2 dst=192.168.0.3 sport=80 dport=47442
 [UPDATE] tcp      6 60 SYN_RECV src=192.168.0.1 dst=192.168.0.3 sport=47442 dport=8080 src=192.168.0.2 dst=192.168.0.3 sport=80 dport=47442
 [UPDATE] tcp      6 432000 ESTABLISHED src=192.168.0.1 dst=192.168.0.3 sport=47442 dport=8080 src=192.168.0.2 dst=192.168.0.3 sport=80 dport=47442 [ASSURED]
 [UPDATE] tcp      6 120 FIN_WAIT src=192.168.0.1 dst=192.168.0.3 sport=47442 dport=8080 src=192.168.0.2 dst=192.168.0.3 sport=80 dport=47442 [ASSURED]
 [UPDATE] tcp      6 30 LAST_ACK src=192.168.0.1 dst=192.168.0.3 sport=47442 dport=8080 src=192.168.0.2 dst=192.168.0.3 sport=80 dport=47442 [ASSURED]
 [UPDATE] tcp      6 120 TIME_WAIT src=192.168.0.1 dst=192.168.0.3 sport=47442 dport=8080 src=192.168.0.2 dst=192.168.0.3 sport=80 dport=47442 [ASSURED]


```

### Links:

- [https://wiki.archlinux.org/title/Port_knocking](https://wiki.archlinux.org/title/Port_knocking)
- [https://putty.org.ru/articles/port-knocking](https://putty.org.ru/articles/port-knocking)
- [Еще несколько слов о Path MTU Discovery Black Hole](https://habr.com/ru/articles/136871/)
- [Блокировать ли ICMP трафик? Вопрос безопасности](https://14bytes.ru/blokirovat-li-icmp-trafik-bezopasno-li/)
--- 
Маркировка трафика (только таблица mangle)
- [https://www.linuxtopia.org/Linux_Firewall_iptables/x4368.html](https://www.linuxtopia.org/Linux_Firewall_iptables/x4368.html)
- [https://unix.stackexchange.com/questions/467076/how-set-mark-option-works-on-netfilter-iptables](https://unix.stackexchange.com/questions/467076/how-set-mark-option-works-on-netfilter-iptables)
---
- [Логирование iptables в отдельный файл](https://habr.com/ru/articles/259169/)