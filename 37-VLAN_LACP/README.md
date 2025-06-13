# Less37. Сетевые пакеты. VLAN'ы. LACP 
- [Less37. Сетевые пакеты. VLAN'ы. LACP](#less37-сетевые-пакеты-vlanы-lacp)
    - [Цель:](#цель)
    - [Содержание:](#содержание)
    - [Результаты:](#результаты)
    - [Компетенции](#компетенции)
    - [Задание:](#задание)
    - [Формат сдачи:](#формат-сдачи)
    - [Критерии оценки:](#критерии-оценки)
    - [Комментарии к выполнению задания:](#комментарии-к-выполнению-задания)
      - [1.Настройка VLAN](#1настройка-vlan)
      - [2. Настройка LACP между хостами inetRouter и centralRouter](#2-настройка-lacp-между-хостами-inetrouter-и-centralrouter)
    - [Links:](#links)

### Цель: 
- изучить UniCast/MultiCast/BroadCast/AnyCast;
- изучить протокол LACP;
- аггрегировать интерфейсы через teaming и bonding;
- VLAN;
- познакомиться с dot1q, macvlan;
- освоить работу с nmcli;
  
### Содержание:
- агрегируем интерфейсы в режиме active/active и failover.
 
### Результаты:
- больше узнать о типах вещания в сетях, понять принципы работы VLAN и научиться использовать LACP

### Компетенции

Работа с сетевой подсистемой
  - настраивать VLAN с помощью встроенных средств операционной системы Linux

 
### Задание:
- Строим бонды и вланы
  
Что нужно сделать?

1) в Office1 в тестовой подсети появляется сервера с доп интерфейсами и адресами
в internal сети testLAN:
  - testClient1 - 10.10.10.254
  - testClient2 - 10.10.10.254
  - testServer1- 10.10.10.1
  - testServer2- 10.10.10.1

2) Развести вланами:
  - testClient1 <-> testServer1
  - testClient2 <-> testServer2

3) Между centralRouter и inetRouter "пробросить" 2 линка (общая inernal сеть) и объединить их в бонд, проверить работу c отключением интерфейсов
   
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

  - файл vagrant [./vagrant37/Vagrantfile](./vagrant37/Vagrantfile)
  - ansible playbook [./vagrant37/ansible/provision.yml](./vagrant37/ansible/provision.yml)
  - файл inventory [./vagrant37/ansible/hosts](./vagrant37/ansible/hosts)
  - каталог шаблонов jinja [./vagrant37/ansible/templates/](./vagrant37/ansible/templates/)

#### 1.Настройка VLAN
  - команды и вывод результатов [./appendix/commandset.md#1](./appendix/commandset.md#1-настройка-vlan)

#### 2. Настройка LACP между хостами inetRouter и centralRouter
  - команды и вывод результатов [./appendix/commandset.md#2](./appendix/commandset.md#2-настройка-lacp-между-хостами-inetrouter-и-centralrouter)


### Links:

- Статья «VLAN» - https://ru.wikipedia.org/wiki/VLAN
- Статья «VLAN для чайников» - https://asp24.ru/novichkam/vlan-dlya-chaynikov/
- Статья «Настройка сети в Linux с помощью netplan» - https://www.dmosk.ru/miniinstruktions.php?mini=network-netplan 
- Статья «Настройка VLAN на Linux CentOS 7» - https://www.dmosk.ru/miniinstruktions.php?mini=vlan-centos 
- Статья «Агрегиование каналов» - https://ru.wikipedia.org/wiki/%D0%90%D0%B3%D1%80%D0%B5%D0%B3%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5_%D0%BA%D0%B0%D0%BD%D0%B0%D0%BB%D0%BE%D0%B2 
- Статья «Настройка Bonding в режиме Active-backup на CentOS» - http://www.zaweel.ru/2016/07/bonding-active-backup-centos-1.html 

==========================
- [http://xgu.ru/wiki/VLAN_%D0%B2_Linux](http://xgu.ru/wiki/VLAN_%D0%B2_Linux)
- [http://xgu.ru/wiki/Linux_Bonding](http://xgu.ru/wiki/Linux_Bonding)
- [http://www.adminia.ru/linux-bonding-obiedinenie-setevyih-interfeysov-v-linux/](http://www.adminia.ru/linux-bonding-obiedinenie-setevyih-interfeysov-v-linux/)
- [https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/networking_guide/ch-configure_network_teaming](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/networking_guide/ch-configure_network_teaming)
- 
