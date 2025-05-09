# Less09. NFS

- [Less09. NFS](#less09-nfs)
    - [Цель:](#цель)
    - [Задание:](#задание)
    - [Компетенции:](#компетенции)
    - [Комментарии к выполнению задания:](#комментарии-к-выполнению-задания)
    - [Links:](#links)

### Цель: 
Научиться самостоятельно разворачивать сервис NFS и подключать к нему клиентов. 

### Задание:
_Что нужно сделать?_
- vagrant up должен поднимать 2 настроенных виртуальных машины (сервер NFS и клиента) без дополнительных ручных действий;
- на сервере NFS должна быть подготовлена и экспортирована директория; 
- в экспортированной директории должна быть поддиректория с именем upload с правами на запись в неё; 
- экспортированная директория должна автоматически монтироваться на клиенте при старте виртуальной машины (systemd, autofs или fstab — любым способом);
- монтирование и работа NFS на клиенте должна быть организована с использованием NFSv3.
    
*Для самостоятельной реализации: 
- настроить аутентификацию через KERBEROS с использованием NFSv4.

### Компетенции:
Администрирование, установка, настройка, отладка серверов Linux
- понимать такие абстракции как VFS, FUSE
- настраивать файловую систему NFS с учетом задач

### Комментарии к выполнению задания:
> Задание выполнено без использования Vagrant

Плейбук [less09_nfs.yml](./playbooks/less09_nfs.yml) выполняет настройку сервиса nfs на сервере, настройку клиента для подключения к файловому ресурсу сервера.

### Links:

- [https://docs.ansible.com/ansible/latest/collections/community/general/parted_module.html](https://docs.ansible.com/ansible/latest/collections/community/general/parted_module.html)

- [https://timeweb.cloud/tutorials/ubuntu/nastrojka-nfs-v-ubuntu](https://timeweb.cloud/tutorials/ubuntu/nastrojka-nfs-v-ubuntu)
- [https://documentation.ubuntu.com/server/how-to/networking/install-nfs/index.html](https://documentation.ubuntu.com/server/how-to/networking/install-nfs/index.html)