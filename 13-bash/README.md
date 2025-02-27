# Less12. BASH
- [Less12. BASH](#less12-bash)
    - [Цель:](#цель)
    - [Задание:](#задание)
    - [Критерии оценки:](#критерии-оценки)
    - [Компетенции:](#компетенции)
    - [Комментарии к выполнению задания:](#комментарии-к-выполнению-задания)
    - [Links:](#links)

### Цель: 
Написать скрипт на языке Bash;

### Задание:
Написать скрипт для CRON, который раз в час будет формировать письмо и отправлять на заданную почту.

Необходимая информация в письме:

Список IP адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта;
Список запрашиваемых URL (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта;
Ошибки веб-сервера/приложения c момента последнего запуска;
Список всех кодов HTTP ответа с указанием их кол-ва с момента последнего запуска скрипта.
Скрипт должен предотвращать одновременный запуск нескольких копий, до его завершения.

В письме должен быть прописан обрабатываемый временной диапазон.

### Критерии оценки:
Трапы и функции, а также sed и find

### Компетенции:
Администрирование, установка, настройка, отладка серверов Linux
- писать скрипты на языке bash
- 
### Комментарии к выполнению задания:

### Links:


======== Основной материал:
- [gnu.org bash](https://www.gnu.org/software/bash/manual/bash.html)
- [gnu.org Shell Expansions/Подстановки](https://www.gnu.org/software/bash/manual/bash.html#Shell-Expansions)
- [gnu.org Подстановки имён файлов (globbing)](https://www.gnu.org/software/bash/manual/bash.html#Filename-Expansion)

======== Расширенные сравнения:
- [What is the difference between test, \[ and \[\[ ?](https://mywiki.wooledge.org/BashFAQ/031)
- [Patterns](https://mywiki.wooledge.org/BashGuide/Patterns)
    

======== Циклы, массивы
- [Циклы. Bash For Loop Examples](https://www.cyberciti.biz/faq/bash-for-loop/)
- [Циклы. Bash Infinite Loop Examples](https://www.cyberciti.biz/faq/bash-infinite-loop/)
    
- [Разделители полей. The Meaning of IFS in Bash Scripting](https://www.baeldung.com/linux/ifs-shell-variable)
- [Массивы. An introduction to Bash arrays](https://opensource.com/article/18/5/you-dont-know-bash-intro-bash-arrays)

======== Other:
- [habr.com Как писать bash-скрипты надежно и безопасно: минимальный шаблон](https://habr.com/ru/articles/590021/)
- [tldp.org.Bash Guide for Beginners](https://tldp.org/LDP/Bash-Beginners-Guide/html/)
- [UbuntuWiki.Bash](https://help.ubuntu.ru/wiki/bash)
- [OpenNet.Искусство программирования на языке сценариев командной оболочки](https://www.opennet.ru/docs/RUS/bash_scripting_guide/)

========
  Онлайновый сервис проверки bash-скриптов
- [ShellCheck](https://www.shellcheck.net/)

======== Mail
- [bsd-mailx / https://manpages.ubuntu.com/manpages/xenial/man1/bsd-mailx.1.html](https://manpages.ubuntu.com/manpages/xenial/man1/bsd-mailx.1.html)
- [How to Use the Linux mail Command](https://phoenixnap.com/kb/linux-mail-command)

  