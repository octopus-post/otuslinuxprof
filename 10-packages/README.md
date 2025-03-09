# Less10. Управление пакетами. Дистрибьюция софта 
- [Less10. Управление пакетами. Дистрибьюция софта](#less10-управление-пакетами-дистрибьюция-софта)
    - [Цель:](#цель)
    - [Содержание](#содержание)
    - [Задание:](#задание)
    - [Компетенции:](#компетенции)
    - [Комментарии к выполнению задания:](#комментарии-к-выполнению-задания)
    - [Links:](#links)

### Цель: 
Научиться собирать RPM-пакеты.
Создавать собственный RPM-репозиторий.

### Содержание
- сборка пакетов (deb и rpm) из исходников;
- создание собственного репозитория с пакетами rpm;

### Задание:
Что нужно сделать?

  -  создать свой RPM (можно взять свое приложение, либо собрать к примеру Apache с определенными опциями);
  -  cоздать свой репозиторий и разместить там ранее собранный RPM;
  -  реализовать это все либо в Vagrant, либо развернуть у себя через Nginx и дать ссылку на репозиторий.


### Компетенции:
Администрирование, установка, настройка, отладка серверов Linux
- собирать установочные пакеты RPM

### Комментарии к выполнению задания:
> задание выполнено на базе ОС Rocky8

1. сборка пакета
   - использован исходник nginx
   - использован исходник ngx_brotli
   - для сборки пакета nginx в файл spec добавлен параметр "--add-module=/root/ngx_brotli"
   - сборка пакета с помощью rpmbuild
       - НЕ СОБРАЛСЯ ПАКЕТ
```bash
make: *** [Makefile:8: build] Error 2
ошибка: Неверный код возврата из /var/tmp/rpm-tmp.o3igEr (%build)
Ошибки сборки пакетов:
    Неверный код возврата из /var/tmp/rpm-tmp.o3igEr (%build)
```

2. развертывание локального репозитория
   - подготовлен каталог для репозитория /usr/share/nginx/html/repo
   - выполнена инициализация репозитория:
   ```bash
   createrepo /usr/share/nginx/html/repo/
   ```
   - в конфигурацию nginx добавлен параметр autoindex on;
   - репозиторий добавлен в список доступных системе (/etc/yum.repos.d)
   - репозиторий доступен для наполнения пакетами и их установки 

### Links:

- [Пример репозитория Ubuntu](http://ru.archive.ubuntu.com/ubuntu/)
- [https://wiki.debian.org/DebianRepository/Format  ](https://wiki.debian.org/DebianRepository/Format)
- [https://ubuntu.com/server/docs/package-management ](https://ubuntu.com/server/docs/package-management)
- [https://wiki.archlinux.org/title/Pacman/Rosetta](https://wiki.archlinux.org/title/Pacman/Rosetta)
- [https://wiki.debian.org/RPM  ](https://wiki.debian.org/RPM  )
- [https://rpm.org/documentation.html  ](https://rpm.org/documentation.html)
- [https://habr.com/ru/articles/301292/   ](https://habr.com/ru/articles/301292/   )
- [https://debian-handbook.info/browse/ru-RU/stable/sect.source-package-structure.html  ](https://debian-handbook.info/browse/ru-RU/stable/sect.source-package-structure.html  )
- [https://habr.com/ru/articles/282217/  ](https://habr.com/ru/articles/282217/  )
- [https://snapcraft.io/docs/installing-snap-on-ubuntu ](https://snapcraft.io/docs/installing-snap-on-ubuntu )
- [https://girirajsharma.wordpress.com/2015/09/27/build-your-own-custom-nginx/ ](https://girirajsharma.wordpress.com/2015/09/27/build-your-own-custom-nginx/ )
- [https://github.com/google/ngx_brotli ](https://github.com/google/ngx_brotli )
- [https://github.com/nixuser/package-example/blob/main/shellspec.spec ](https://github.com/nixuser/package-example/blob/main/shellspec.spec )
- 
- 