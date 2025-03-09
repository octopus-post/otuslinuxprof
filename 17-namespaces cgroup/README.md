# Less17. Механизмы изоляции и аккаунтинга Linux (namespaces и cgroup)
- [Less17. Механизмы изоляции и аккаунтинга Linux (namespaces и cgroup)](#less17-механизмы-изоляции-и-аккаунтинга-linux-namespaces-и-cgroup)
    - [Цель:](#цель)
    - [Содержание](#содержание)
    - [Задание:](#задание)
    - [Компетенции:](#компетенции)
    - [Комментарии к выполнению задания:](#комментарии-к-выполнению-задания)
    - [Links:](#links)

### Цель: 
использовать технологии контейнеризации осознанно;
изолировать процессы друг от друга встроенными в
дистрибутив средствами;

### Содержание
- цели контейнеризации;
- два механизма, на которых строится вся контейнеризация на базе linux;
- управление и мониторинг без использования систем управления контейнерами;
- простейшая система контейнеризации на базе systemd-nspawn.

### Задание:


### Компетенции:
Администрирование, установка, настройка, отладка серверов Linux
- понимать работу с механизмов namespaces и cgroups


### Комментарии к выполнению задания:

### Links:

- [chroot(2) — Linux manual page](https://man7.org/linux/man-pages/man2/chroot.2.html)
- [https://docs-archive.freebsd.org/44doc/papers/jail/jail-9.html](https://docs-archive.freebsd.org/44doc/papers/jail/jail-9.html)
- [cgroups(7) — Linux manual page](https://man7.org/linux/man-pages/man7/cgroups.7.html)
  - [Control Groups version 1](https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v1/index.html#cgroup-v1)
  - [Control Group v2](https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html)
- cgroup & systemd
  - [26.8. I/O bandwidth configuration options for systemd](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/managing_monitoring_and_updating_the_kernel/assembly_configuring-resource-management-using-systemd_managing-monitoring-and-updating-the-kernel#ref_i-o-bandwidth-configuration-options-with-systemd_assembly_configuring-resource-management-using-systemd_managing-monitoring-and-updating-the-kernel)
  - [23.2. Introducing kernel resource controllers](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/managing_monitoring_and_updating_the_kernel/setting-limits-for-applications_managing-monitoring-and-updating-the-kernel#what-kernel-resource-controllers-are_setting-limits-for-applications)
  - [Managing cgroups with systemd](https://www.redhat.com/en/blog/cgroups-part-four)
  - [How to manage cgroups with CPUShares](https://www.redhat.com/en/blog/cgroups-part-two)
- namespaces
  - [namespaces(7) — Linux manual page](https://man7.org/linux/man-pages/man7/namespaces.7.html)
  - [Глубокое погружение в Linux namespaces](https://habr.com/ru/articles/458462/)
  - [The 7 most used Linux namespaces](https://www.redhat.com/en/blog/7-linux-namespaces)
  