# Less11. GRUB
- [Less11. GRUB](#less11-grub)
    - [Цель:](#цель)
    - [Задание:](#задание)
    - [Компетенции:](#компетенции)
    - [Комментарии к выполнению задания:](#комментарии-к-выполнению-задания)
    - [Links:](#links)

### Цель: 
- Научиться попадать в систему без пароля;
- Устанавливать систему с LVM и переименовывать в VG.

### Задание:

1. Включить отображение меню Grub.
2. Попасть в систему без пароля несколькими способами.
3. Установить систему с LVM, после чего переименовать VG.


### Компетенции:
Администрирование, установка, настройка, отладка серверов Linux:

- понимать работу загрузчика grub2, конфигурировать его параметры на этапе настройки и на этапе загрузки
- уметь войти в систему без знания пароля

### Комментарии к выполнению задания:

1. Порядок включения меню загрузки GRUB (по умолчанию выключен в ubuntu) и подготовка системы к загрузке в однопользовательском режиме root представлен в файле [typescript01](./typescript01).
  
    1.1. Далее для запуска системы с правами root и монтирования fs в режиме rw можно воспользоваться контекстом edit в меню GRUB:
    - В строке загрузки ядра добавить init=/bin/bash
    - Для монтирования корневой fs в режиме редактирования изменить ro на rw или перемонтировать корневую fs после перезагрузки командой 
    ```bash
        mount -o remount,rw /
    ```
    - После перезагрузки можно изменить пароль root и выполнять любые действия с системой от root.

    1.2. Или из меню запуска Advanced Options -> Recovery Mode (в псевдографическом режиме):
    - здесь можно выбрать команды 
      - clean (попытаться освободить немного места), 
      - dpkg (восстановление повреждённых пакетов), 
      - fsck (проверка fs), 
      - grub (обновить загрузчик grub),
      - system-summary (информация о системе),
      - или перейти в консоль.
    - для запуска монтирования файловой системы в режиме редактирования выбрать пункт _\<network\>_.
    - для перехода в консоль выбрать пункт _\<root\>_ для выполнения команд в консоли.
    - после ввода пароля пользователя root можно выполнять любые действия от root.

2. Изменение имени VG и внесение изменений в конфигурацию GRUB представлены в файле [typescript02](./typescript02).

После перезагрузки вывод lsblk:
```bash
alex@ubuntu24-pro:~$ lsblk
NAME                          MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sr0                            11:0    1 1024M  0 rom  
vda                           253:0    0   20G  0 disk 
├─vda1                        253:1    0    1M  0 part 
├─vda2                        253:2    0  1,8G  0 part /boot
└─vda3                        253:3    0 18,2G  0 part 
  └─ubuntu--vgotus-ubuntu--lv 252:0    0   10G  0 lvm  /
```

### Links:

- Описание параметров ядра: [https://www.kernel.org/doc/Documentation/admin-guide/kernel-parameters.txt](https://www.kernel.org/doc/Documentation/admin-guide/kernel-parameters.txt)
- [https://www.layerstack.com/resources/tutorials/Resetting-root-password-for-Linux-Cloud-Server](https://www.layerstack.com/resources/tutorials/Resetting-root-password-for-Linux-Cloud-Server
)
- [https://manpages.ubuntu.com/manpages/focal/en/man8/update-initramfs.8.html](https://manpages.ubuntu.com/manpages/focal/en/man8/update-initramfs.8.html)
- [https://mirrors.edge.kernel.org/pub/linux/utils/boot/dracut/dracut.html](https://mirrors.edge.kernel.org/pub/linux/utils/boot/dracut/dracut.html)
- [https://manpages.ubuntu.com/manpages/bionic/en/man5/initramfs.conf.5.html](https://manpages.ubuntu.com/manpages/bionic/en/man5/initramfs.conf.5.html)
- [Восстановление GRUB2](https://losst.pro/vosstanovlenie-grub2)