# Less33. Статическая и динамическая маршрутизация, OSPF 
- [Less33. Статическая и динамическая маршрутизация, OSPF](#less33-статическая-и-динамическая-маршрутизация-ospf)
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
- понять принцип работы multicast;
- описать назначение loopback-интерфейса;
- понять основные принципы работы протокола OSPF;
- настроить динамическую маршрутизацию с помощью программных маршрутизаторов Quagga, FRR и BIRD.
  
### Содержание:
- Aggregate и specific сети;
- куда ведет blackhole;
- принципы маршрутизации с помощью loopback;
- что такое multicast;
- отличия статической и динамической маршрутизации;
- как работает OSPF.
 
### Результаты:
- навыки работы со статической и динамической маршрутизацией, навыки настройки программных маршрутизаторов.
### Компетенции

Работа с сетевой подсистемой
- работать с протоколом OSPF
- настраивать динамическую маршрутизацию с помощью программных маршрутизаторов Quagga, FRR и BIRD
### Задание:
Что нужно сделать?

1. Поднять три виртуалки
2. Объединить их разными vlan
    - поднять OSPF между машинами на базе Quagga;
    - изобразить ассиметричный роутинг;
    - сделать один из линков "дорогим", но что бы при этом роутинг был симметричным.

### Формат сдачи: 
Формат сдачи: Vagrantfile + ansible

### Критерии оценки:

### Комментарии к выполнению задания:
> _Задание выполнено с использованием:_
> - Vagrant 2.4.5
> - Virtualbox 7.1.8 r168469
> - vagrant box: ubuntu/focal20.04
> - Ansible [core 2.18.5]

Файлы конфигурации для работы с сетевым стендом OSPF:
1. [Vagrantfile](./vagrant33/Vagrantfile)
2. [ansible-playbook](./vagrant33/ansible/provision.yml)
3. файл конфигурации ansible [ansible.cfg](./vagrant33/ansible/ansible.cfg)
4. файл инвентаризаци [hosts](./vagrant33/ansible/hosts)
5. переменные [./ansible/defaults/main.yml](./vagrant33/ansible/defaults/main.yml)
6. каталог шаблонов [./ansible/templates/](./vagrant33/ansible/templates/)
7. файлы конфигураций daemons и frr [./files/](./files/)
8. листинг команд и вывод результатов [commandset.md](./appendix/commandset.md)



### Links:

- [Статья «OSPF»](https://ru.bmstu.wiki/OSPF_(Open_Shortest_Path_First)#.D0.A2.D0.B5.D1.80.D0.BC.D0.B8.D0.BD.D1.8B_.D0.B8_.D0.BE.D1.81.D0.BD.D0.BE.D0.B2.D0.BD.D1.8B.D0.B5_.D0.BF.D0.BE.D0.BD.D1.8F.D1.82.D0.B8.D1.8F_OSPF)
- [Статья «IP Routing: OSPF Configuration Guide»](https://www.cisco.com/c/en/us/td/docs/ios-xml/ios/iproute_ospf/configuration/xe-16/iro-xe-16-book/iro-cfg.html)
- [Документация FRR](http://docs.frrouting.org/en/latest/overview.html)
- [Статья «Принципы таблицы маршрутизации. Асимметричная маршрутизация»](http://marshrutizatciia.ru/principy-tablicy-marshrutizacii-asimmetrichnaya-marshrutizaciya.html)
- [Различия межлу протоколами OSPF](https://da2001.ru/CCNA_5.02/2/course/module8/8.3.1.3/8.3.1.3.html#:~:text=%D0%9A%D0%BE%D0%BD%D1%84%D0%B8%D0%B3%D1%83%D1%80%D0%B0%D1%86%D0%B8%D1%8F%20OSPFv3%20%D0%B4%D0%BB%D1%8F%20%D0%BE%D0%B4%D0%BD%D0%BE%D0%B9%20%D0%BE%D0%B1%D0%BB%D0%B0%D1%81%D1%82%D0%B8&text=%D0%98%D1%81%D1%85%D0%BE%D0%B4%D0%BD%D1%8B%D0%B9%20%D0%B0%D0%B4%D1%80%D0%B5%D1%81%20%E2%80%94%20%D1%81%D0%BE%D0%BE%D0%B1%D1%89%D0%B5%D0%BD%D0%B8%D1%8F%20OSPFv2%20%D0%BF%D0%BE%D1%81%D1%82%D1%83%D0%BF%D0%B0%D1%8E%D1%82,%D1%82%D0%B8%D0%BF%D0%B0%20link%2Dlocal%20%D0%B2%D1%8B%D1%85%D0%BE%D0%B4%D0%BD%D0%BE%D0%B3%D0%BE%20%D0%B8%D0%BD%D1%82%D0%B5%D1%80%D1%84%D0%B5%D0%B9%D1%81%D0%B0)
- [Документация по Templating(jinja2)](https://docs.ansible.com/ansible/2.9/user_guide/playbooks_templating.html)

