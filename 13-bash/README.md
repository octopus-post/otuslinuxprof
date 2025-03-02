# Less13. BASH
- [Less13. BASH](#less13-bash)
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

- Список IP адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта;
- Список запрашиваемых URL (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта;
- Ошибки веб-сервера/приложения c момента последнего запуска;
- Список всех кодов HTTP ответа с указанием их кол-ва с момента последнего запуска скрипта.
- Скрипт должен предотвращать одновременный запуск нескольких копий, до его завершения.

В письме должен быть прописан обрабатываемый временной диапазон.

### Критерии оценки:
Трапы и функции, а также sed и find

### Компетенции:
Администрирование, установка, настройка, отладка серверов Linux
- писать скрипты на языке bash
- 
### Комментарии к выполнению задания:
1. Скрипт [get_log.sh](./files/get_log.sh) выполняется каждый час ([crontab.txt](./files/cronetab.txt)).  
2. Для предотвращения запуска нескольких копий скрипта перед запуском проверяется наличие файла donottouch в текущем каталоге.
3. Результат работы сервера за последний час сохраняется во временном файле /opt/nginx_logs/logs/access_<%d_%b_%Y-%H-%M>.log
4. Результаты сохраняются в файлах 
   - [get_log_GET](./files/get_log_GET), 
   - [get_log_URL](./files/get_log_URL), 
   - [get_log_ERR](./files/get_log_ERR), 
   - [get_log_CODE](./files/get_log_CODE)
5. Администратору отправляется письмо с вложениями. Результат отправки - [mail.txt](./files/mail.txt).

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

  