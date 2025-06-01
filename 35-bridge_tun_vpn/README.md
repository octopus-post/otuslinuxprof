# Less35. VPN
- [Less35. VPN](#less35-vpn)
    - [Цель:](#цель)
    - [Содержание:](#содержание)
    - [Результаты:](#результаты)
    - [Компетенции](#компетенции)
    - [Задание:](#задание)
    - [Формат сдачи:](#формат-сдачи)
    - [Критерии оценки:](#критерии-оценки)
    - [Комментарии к выполнению задания:](#комментарии-к-выполнению-задания)
      - [1. TUN/TAP режимы VPN](#1-tuntap-режимы-vpn)
      - [2. RAS на базе OpenVPN](#2-ras-на-базе-openvpn)
    - [Links:](#links)

### Цель: 
- описать разницу между мостами и туннелями;
- настраивать мосты и туннели между сетями;
- разобраться в различных типах реализаций мостов и туннелей.
  
### Содержание:
- Bridge;
- IPsec;
- PPTP;
- openVPN;
- TUN/TAP;
- WireGuard.
 
### Результаты:
- научиться разбираться в терминологии различных технологий VPN и смогут поднять свой собственный VPN сервер.

### Компетенции

Работа с сетевой подсистемой
- настраивать туннели, VPN и мостов с помощью операционной системы Linux
 
### Задание:
- Создать домашнюю сетевую лабораторию. Научится настраивать VPN-сервер в Linux-based системах.
- 
Что нужно сделать?

1)Настроить VPN между двумя ВМ в tun/tap режимах, замерить скорость в туннелях, сделать вывод об отличающихся показателях
2)Поднять RAS на базе OpenVPN с клиентскими сертификатами, подключиться с локальной машины на ВМ
Задание со звездочкой
3)Самостоятельно изучить и настроить ocserv, подключиться с хоста к ВМ

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

#### 1. TUN/TAP режимы VPN
   - раскомментировать блок *"Ansible playbook TUN/TAP"* в конфигурации vagrant [./vagrant35/Vagrantfile](./vagrant35/Vagrantfile)
   - каталог шаблонов [./vagrant35/ansible/templates/](./vagrant35/ansible/templates/)
   - ansible playbook [./vagrant35/ansible/provision_tun_tap.yml](./vagrant35/ansible/provision_tun_tap.yml)
     - формирует файл конфигурации [server.conf.j2](./vagrant35/ansible/templates/server.conf.j2)
     - генерирует PSK-ключ на сервере и копирует на клиента
     - формирует конфигурацию и запускает юнит openvpn
   - вывод команд проверки конфигураций и тестов [./appendix/commandset.md#1-tuntap-режимы-vpn](./appendix/commandset.md#1-tuntap-режимы-vpn)
  
> _переключение режимов TUN/TAP - в переменной dev_mod [./vagrant35/ansible/defaults/main.yml](./vagrant35/ansible/defaults/main.yml)_

#### 2. RAS на базе OpenVPN
   - раскомментировать блок *"Ansible playbook RAS over OVPN"* в конфигурации vagrant [./vagrant35/Vagrantfile](./vagrant35/Vagrantfile)
   - каталог шаблонов [./vagrant35/ansible/templates/](./vagrant35/ansible/templates/)
   - ansible playbook [./vagrant35/ansible/provision_ras.yml](./vagrant35/ansible/provision_ras.yml)
     - инициализирует PKI, генерирует ключи и сертификаты и копирует на хост
     - формирует конфигурацию сервера из шаблона [./vagrant35/ansible/templates/server.conf.ras.j2](./vagrant35/ansible/templates/server.conf.ras.j2)
     - запускает юнит openvpn
   - вывод команд проверки конфигураций и тестов [./appendix/commandset.md#2-ras-openvpn](./appendix/commandset.md#2-ras-openvpn)
  
> _после завершения работы плейбука  скопировать из каталога ./vagrant35/ansible/pki файлы ca.crt, client.crt, client.key на хосте в каталог /etc/openvpn/_

### Links:

- [commandset.md](./appendix/commandset.md) 
