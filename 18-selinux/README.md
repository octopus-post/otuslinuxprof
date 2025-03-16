# Less18. SELinux - когда все запрещено
- [Less18. SELinux - когда все запрещено](#less18-selinux---когда-все-запрещено)
    - [Цель:](#цель)
    - [Содержание](#содержание)
    - [Задание:](#задание)
    - [Критерии оценки:](#критерии-оценки)
    - [Компетенции:](#компетенции)
    - [Комментарии к выполнению задания:](#комментарии-к-выполнению-задания)
      - [Задание 1. Запуск nginx на нестандартном порту 3-мя разными способами](#задание-1-запуск-nginx-на-нестандартном-порту-3-мя-разными-способами)
      - [Задание 2. Обеспечение работоспособности приложения при включенном SELinux](#задание-2-обеспечение-работоспособности-приложения-при-включенном-selinux)
    - [Links:](#links)

### Цель: 
- объяснить, что такое системы принудительного контроля доступа;
- объяснить, как работает система SELinux;
- работать с системой SELinux.

### Содержание
- краткая история создания системы SELinux;
- основные термины и понятия связанные с системой SELinux;
- основные приемы работы с политиками SELinux.

### Задание:
- работать с SELinux: диагностировать проблемы и модифицировать политики SELinux для корректной работы приложений, если это требуется;

1. Запустить nginx на нестандартном порту 3-мя разными способами:

  - переключатели setsebool;
  - добавление нестандартного порта в имеющийся тип;
  - формирование и установка модуля SELinux.
    К сдаче:
    README с описанием каждого решения (скриншоты и демонстрация приветствуются).


2. Обеспечить работоспособность приложения при включенном selinux.

  - развернуть приложенный стенд https://github.com/mbfx/otus-linux-adm/tree/master/selinux_dns_problems;
  - выяснить причину неработоспособности механизма обновления зоны (см. README);
  - предложить решение (или решения) для данной проблемы;
  - выбрать одно из решений для реализации, предварительно обосновав выбор;
  - реализовать выбранное решение и продемонстрировать его работоспособность.

    К сдаче:
    README с анализом причины неработоспособности, возможными способами решения и обоснованием выбора одного из них;
    исправленный стенд или демонстрация работоспособной системы скриншотами и описанием.

### Критерии оценки:

Статус "Принято" ставится при выполнении следующих условий:

  - для задания 1 описаны, реализованы и продемонстрированы все 3 способа решения;
  - для задания 2 описана причина неработоспособности механизма обновления зоны;
  - для задания 2 реализован и продемонстрирован один из способов решения.

Опционально для выполнения:

  - для задания 2 предложено более одного способа решения;
  - для задания 2 обоснованно(!) выбран один из способов решения.

### Компетенции:
Обеспечение стабильности
    - конфигурировать политики SELinux

### Комментарии к выполнению задания:
  > _Задание выполнено c использованием Vagrant, vagrant box Almalinux8_

#### Задание 1. Запуск nginx на нестандартном порту 3-мя разными способами
- [Vagrantfile](./files/task01/Vagrantfile)
- Результаты выполнения и описание действий в файле [typescript01](./files/task01/typescript01)

#### Задание 2. Обеспечение работоспособности приложения при включенном SELinux
- [Vagrantfile](./files/task02/Vagrantfile)
- Результаты выполнения и описание действий в файле [typescript02](./files/task02/typescript02)

> При разворачивании стенда необходимо:
>    - в vagrantfile изменить провайдера на libvirt
>    - для задания 2 при запуске ansible playbook плей установки пакетов завершается с ошибкой. Установить пакеты вручную и и запустить playbook командой ```vagrant provision``` _(расмотреть рабочие варианты)_

### Links:

  > [Для задания 1 исходный стенд Vagrant на github.com/Nickmob/](https://github.com/Nickmob/vagrant_selinux)
  > [Для задания 2 исходный стенд Vagrant на github.com/Nickmob/](https://github.com/Nickmob/vagrant_selinux_dns_problems)


  > [Дополнительный стенд](https://github.com/mbfx/otus-linux-adm/tree/master/selinux_dns_problems)

- [https://wiki.gentoo.org/wiki/SELinux](https://wiki.gentoo.org/wiki/SELinux)
- [https://wiki.gentoo.org/wiki/SELinux/Tutorials/The_purpose_of_SELinux_roles](https://wiki.gentoo.org/wiki/SELinux/Tutorials/The_purpose_of_SELinux_roles)

- [https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/selinux_users_and_administrators_guide/part_i-selinux](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/selinux_users_and_administrators_guide/part_i-selinux)
- [https://habr.com/ru/companies/otus/articles/484896/](https://habr.com/ru/companies/otus/articles/484896/)
- [Как установить SELinux на Ubuntu 22.04](https://www.linode.com/docs/guides/how-to-install-selinux-on-ubuntu-22-04/)
- [https://access.redhat.com/documentation/ru-ru/red_hat_enterprise_linux/8/html/using_selinux/writing-a-custom-selinux-policy_using-selinux#creating-and-enforcing-an-selinux-policy-for-a-custom-application_writing-a-custom-selinux-policy](https://access.redhat.com/documentation/ru-ru/red_hat_enterprise_linux/8/html/using_selinux/writing-a-custom-selinux-policy_using-selinux#creating-and-enforcing-an-selinux-policy-for-a-custom-application_writing-a-custom-selinux-policy)



  