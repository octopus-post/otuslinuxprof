# Пример работы port knoking
```bash
$ ssh username@hostname # No response (Ctrl+c to exit)
^C
$ nmap -Pn --host-timeout 201 --max-retries 0  -p 1111 host #knocking port 1111
$ nmap -Pn --host-timeout 201 --max-retries 0  -p 2222 host #knocking port 2222
$ ssh user@host # Now logins are allowed
user@host's password:
```
# Simple port knocking
## 2.1. Server side
### 2.1.1. With a daemon helper
    > необходимо внести изменений в цепочку INPUT

- Запущен демон ssh, который ожидает входящих соединений на tcp-порту 22. Но правилом iptable входящие соединения на порт 22 запрещены
- Knockd, прослушивает интерфейс ethX и ожидает последовательности из TCP SYN-пакетов на порты 8881:tcp,7777:tcp,9991:tcp. 
- Как только последовательность будет обнаружена, knockd при помощи вызова iptables изменит правило сетевого трафика так, чтобы разрешить подключение извне к tcp-порту 22, на которм уже ожидает демон ssh.

Файл конфигурации демона knockd - /etc/knockd.conf

```[options]``` - глобальные настройки демона

```Interface = eth1``` - определяем интерфейс для прослушивания демоном knockd

```bash
# For example:
    [options]
        logfile = /var/log/knockd.log
    [opencloseSSH]
        # последовательность и типы портов
        sequence      = 8881:tcp,7777:tcp,9991:tcp
        # максимальное время в секундах для совершения последовательности подключений
        seq_timeout   = 15
        # определяем какие флаги должны иметь пакеты, участвующие в последовательности
        tcpflags      = syn,ack
        # command определяет путь и параметры вызываемой программы в случае обнаружения корректной последовательности.
        # start_command по смыслу идентичен параметру command
        start_command = /usr/bin/iptables -A TCP -s %IP% -p tcp --dport 22 -j ACCEPT
        # cmd_timeout определяет временной интервал в секундах, по истечении которого запустится команда, определённая значением параметра stop_command, т.е. можно открывать порт лишь на промежуток времени
        cmd_timeout   = 10
        stop_command  = /usr/bin/iptables -D TCP -s %IP% -p tcp --dport 22 -j ACCEPT
```   

Чтобы демон knockd запускался автоматически при старте системы, достаточно в файле ```/etc/default/knockd``` установить:
```bash
START_KNOCKD=1
```
#### Настройка клиента
```bash
knock 192.168.1.100 3333:tcp 9999:udp 1010:udp 8675:tcp
```

### 2.1.2 With iptables only

Следующая конструкция реализована в файле ```/etc/iptables/iptables.rules``` для обработки port knoking для SSH. Правила определяют открытие порта 22 после серии knoks на порты 8881, 7777 и 9991 в таком порядке.

Сначала необходимо определить политику по умолчанию и цепоч

## 2.2 Client script

```bash
/usr/local/bin/knock

#!/bin/bash
HOST=$1
shift
for ARG in "$@"
do
        nmap -Pn --host-timeout 100 --max-retries 0 -p $ARG $HOST
done
```

```bash 
alias knock="nc -z"
```