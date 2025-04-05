# Less24. Пользователи и группы. Авторизация и аутентификация
- [Less24. Пользователи и группы. Авторизация и аутентификация](#less24-пользователи-и-группы-авторизация-и-аутентификация)
    - [Цель:](#цель)
    - [Содержание:](#содержание)
    - [Результаты:](#результаты)
    - [Задание:](#задание)
    - [Формат сдачи:](#формат-сдачи)
    - [Критерии оценки:](#критерии-оценки)
    - [Компетенции:](#компетенции)
    - [Комментарии к выполнению задания:](#комментарии-к-выполнению-задания)
    - [Links:](#links)

### Цель: 
- рассмотреть механизмы авторизации и аутентификации;
- объяснить какие бывают права у пользовталей;
- управлять правами с помощью sudo, umask. sgid, suid и более сложными инструментами как PAM и ACL, PolicyKit.
- научиться создавать пользователей и добавлять им ограничения;
  
### Содержание:
- лабораторная работа: даем пользователю A возможность запускать скрипт, принадлежащий пользователю B.
### Результаты:
- освоить инструменты для управлением правами пользователей, контролем авторизации и выдачи прав.
### Задание:
- Запретить всем пользователям, кроме группы admin логин в выходные (суббота и воскресенье), без учета праздников
- Дать конкретному пользователю права работать с докером и возможность рестартить докер сервис*

### Формат сдачи: 
- Vagrantfile + ansible

### Критерии оценки:
- Статус "Принято" ставится при выполнении описанного требования.
- Доп. задание выполняется по желанию.

### Компетенции:
Обеспечение стабильности
   - работать с базовыми механизмами авторизации и аутентификации, базовыми инструментами для выдачи прав на работу с файлами и процессами разным группам пользователей

  
### Комментарии к выполнению задания:


### Links:

- [Управление пользователями](https://firstvds.ru/technology/linux-user-management#:~:text=%D0%92%20Linux%20%D1%81%D1%83%D1%89%D0%B5%D1%81%D1%82%D0%B2%D1%83%D1%8E%D1%82%20%D1%82%D1%80%D0%B8%20%D1%82%D0%B8%D0%BF%D0%B0,%D0%9B%D0%BE%D0%BA%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B5%20%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D1%82%D0%B5%D0%BB%D0%B8%20%E2%80%94%20%D0%BD%D0%B5%D0%BF%D1%80%D0%B8%D0%B2%D0%B8%D0%BB%D0%B5%D0%B3%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%BD%D1%8B%D0%B5%20%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D1%82%D0%B5%D0%BB%D0%B8)
- [CAP_SYS_ADMIN: the new root](https://lwn.net/Articles/486306/)
- [Как работает PAM (Pluggable Authentication Modules) (pam auth linux security howto)](https://www.opennet.ru/base/net/pam_linux.txt.html)
- [What is PAM?](https://medium.com/information-and-technology/wtf-is-pam-99a16c80ac57)
- [pam_time (8) - Linux Manuals](https://www.systutorials.com/docs/linux/man/8-pam_time/)

---
- [https://wiki.archlinux.org/title/PAM)](https://wiki.archlinux.org/title/PAM_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9))
- [https://www.altlinux.org/Polkit](https://www.altlinux.org/Polkit)
- [https://losst.pro/nastrojka-pam-v-linux](https://losst.pro/nastrojka-pam-v-linux)
- [https://github.com/linux-pam/linux-pam](https://github.com/linux-pam/linux-pam)
- [digitalocean: how-to-edit-the-sudoers-file](https://www.digitalocean.com/community/tutorials/how-to-edit-the-sudoers-file)  