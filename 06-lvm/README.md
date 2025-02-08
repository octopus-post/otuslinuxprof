# Less06. Работа с LVM
### Цель: создавать и работать с логическими томами;


### Задание:
_Что нужно сделать?_

На имеющемся образе bento/ubuntu-24.04

    1. Уменьшить том под / до 8G.
    2. Выделить том под /home.
    3. Выделить том под /var - сделать в mirror.
    4. /home - сделать том для снапшотов.
    5. Прописать монтирование в fstab. Попробовать с разными опциями и разными файловыми системами (на выбор).
    6. Работа со снапшотами:
        a. сгенерить файлы в /home/;
        b. снять снапшот;
        c. удалить часть файлов;
        d. восстановится со снапшота.

    7. * На дисках попробовать поставить btrfs/zfs — с кэшем, снапшотами и разметить там каталог /opt.
_Логировать работу можно с помощью утилиты script._

### Компетенции:
Администрирование, установка, настройка, отладка серверов Linux

    - разбираться в параметрах монтирования
    - работать с LVM, управлять дисковым пространством, делать снапшоты

### Комментарии:

Выполнение ДЗ представлено в виде листинга в файле _less07_command_log.txt_

### Links:
[https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/6/html/logical_volume_manager_administration/index](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/6/html/logical_volume_manager_administration/index)

[https://pingvinus.ru/note/terminal-script-command](https://pingvinus.ru/note/terminal-script-command)