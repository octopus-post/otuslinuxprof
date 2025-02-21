# Less12. Systemd - создание unit-файла
- [Less12. Systemd - создание unit-файла](#less12-systemd---создание-unit-файла)
    - [Цель:](#цель)
    - [Задание:](#задание)
    - [Компетенции:](#компетенции)
    - [Комментарии к выполнению задания:](#комментарии-к-выполнению-задания)
    - [Links:](#links)

### Цель: 
Научиться редактировать существующие и создавать новые unit-файлы;

### Задание:
1. Написать service, который будет раз в 30 секунд мониторить лог на предмет наличия ключевого слова (файл лога и ключевое слово должны задаваться в /etc/default).  
2. Установить spawn-fcgi и создать unit-файл (spawn-fcgi.sevice) с помощью переделки init-скрипта ([https://gist.github.com/cea2k/1318020](https://gist.github.com/cea2k/1318020)).  
3. Доработать unit-файл Nginx (nginx.service) для запуска нескольких инстансов сервера с разными конфигурационными файлами одновременно.

### Компетенции:
Администрирование, установка, настройка, отладка серверов Linux
- настраивать Systemd units для управления процессами

### Комментарии к выполнению задания:
1. Юнит для поиск текста в файле 
    - [watchlog.service](./files/part1/watchlog.service)
    - [watchlog.timer](./files/part1/watchlog.timer)
    - [результат работы юнитов](./files/part1/typescript01)
2. spawn-fcgi сервис
    - [исходный файл php_cgi](./files/part2/php_cgi)
    - [fcgi.conf](./files/part2/fcgi.conf)
    - [spawn-fcgi.service](./files/part2/spawn-fcgi.service)
    - [typescript02](./files/part2/typescript02)
3. запуск нескольких инстансов сервера nginx
    - [nginx-first.conf](./files/part3/nginx-first.conf)
    - [nginx-second.conf](./files/part3/nginx-second.conf)
    - [шаблон nginx@.service](./files/part3/nginx@.service)
    - [typescript03](./files/part3/typescript03)


### Links:

[https://freedesktop.org/wiki/Software/systemd/](https://freedesktop.org/wiki/Software/systemd/)
[https://www.freedesktop.org/software/systemd/man/systemd.exec.html](https://www.freedesktop.org/software/systemd/man/systemd.exec.html)
[https://www.freedesktop.org/software/systemd/man/index.html](https://www.freedesktop.org/software/systemd/man/index.html)