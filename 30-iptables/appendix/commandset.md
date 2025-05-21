# Материалы к уроку 30. Iptables
- [111]
(#)

Подсистема netfilter
    - iptables
    - ip6tables
  Надстройки
  - ufw (ubuntu) над iptables
  - firewalld (centos) над iptables b nf_tables

![alt text](image.png)
















![alt text](image-1.png)


















Иерархия

 - таблицы (raw, mangle, nat, filter)
 - цепочки (PREROUTING, INPUT, FORWARD, OUTPUT, POSTROUTING)
 - правила:
   - размещаются на пересечении таблиц и цепочек
   - применяются по порядку

![alt text](image-2.png)

















![alt text](image-3.png)



















## Команды iptables

- iptables -L – просмотр списка правил
- iptables -F – сброс правил (политика остаётся)
- iptables -P – установка политики по умолчанию
- iptables -I – вставить правило в начало списка
- iptables -A – добавить правило в конец списка
- iptables -D – удалить правило

```bash
iptables -nvL # по умолчанию таблица filter (-t filter)
iptables -nvL -t raw
iptables -nvL -t mangle
iptables -nvL -t nat
# определяем какой сервис используется
iptables -V
iptables v1.8.11 (nf_tables)
# или
nft list ruleset #< правила nft>
# сброс правил
nft flush ruleset #< сброс правил nft>
...
# или находим iptables
 ╭─alex@smith in ~ as 🧙 took 0s
 ╰─λ which iptables
/usr/bin/iptables

 ╭─alex@smith in ~ as 🧙 took 0s
 ╰─λ ls -al /usr/bin/iptables
lrwxrwxrwx 1 root root 17 мар 23 00:58 /usr/bin/iptables -> xtables-nft-multi

 ╭─alex@smith in ~ as 🧙 took 0s
 ╰─λ ls -al /usr/bin/xtables-nft-multi
-rwxr-xr-x 1 root root 211872 мар 23 00:58 /usr/bin/xtables-nft-multi

```

## Критерии правил в iptables
- -p – протокол
- -i – интерфейс источника
- -o – интерфейс назначения
- -s – адрес источника
- --dport – порт назначения
- --sport – порт источника
- -m multiport --dports – несколько портов назначения
- -m conntrack --ctstate – статус соединения (или ранее -m state --state)
- --icmp-type – тип ICMP-сообщения
- -j – действие

## Действия с пакетами — target, jump (-j)
- ACCEPT — разрешить
- DROP — выкинуть
- REJECT — отклонить
  - ```iptables -A INPUT -s 10.26.95.20 -j REJECT --reject-with tcp-reset```
  - ```iptables -A INPUT -p tcp -j REJECT --reject-with tcp-reset``` 
  - ```iptables -A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable```
  - ```iptables -A INPUT -j REJECT --reject-with icmp-proto-unreachable```
- REDIRECT — перенаправить
  - ```iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080```
- DNAT/SNAT — destination/source NAT (network address translation)
  - ```iptables -t nat -A PREROUTING -p tcp --dport 9022 -j DNAT --to 192.168.56.6:22```
- LOG — записать в лог
- RETURN — выйти из цепочки

## Состояния пакетов
- Сохранение состояния соединений — stateful firewall
- lsmod | grep conntrack
- ```iptables -A INPUT -m conntrack --ctstate INVALID -j DROP```
  - NEW — пакет для создания нового соединения
  - ESTABLISHED — пакет, принадлежащий к существующему соединению
  - RELATED — пакет для создания нового соединения, но связанный с существующим (например, FTP)
  - INVALID — пакет не соответствует ни одному соединению из таблицы
  - UNTRACKED — пакет был помечен как неотслеживаемый в таблице raw

```bash
# пример набора правил iptables
# разрешаем loopback
iptables -A INPUT -i lo -j ACCEPT
# Дропаем невалидные пакеты
iptables -A INPUT -i enp0s3 -m conntrack --ctstate INVALID -j DROP
# Разрешить только те пакеты, которые мы запросили
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
# Заблокиривать запросы ping
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
# разрешаем протокол icmp для прохождения пакетов диагностики сети
iptables -A INPUT -p icmp -j ACCEPT
# разрешаем соединение по ssh
iptables -A INPUT -p tcp --dport=22 -m conntrack --ctstate NEW -j ACCEPT
# разрешаем соединение на веб-сервер
iptables -A INPUT -p tcp -m multiport --dport=80,443 -m conntrack --ctstate NEW -j ACCEPT
# устанавлияваем политику по умолчанию
iptables -P INPUT DROP

```
```
iptables -[ACD] chain rule-specification [options]
  --numeric	-n		numeric output of addresses and ports
  --verbose	-v		verbose mode
  --list    -L [chain [rulenum]] List the rules in a chain or all chains
  --table	  -t table	table to manipulate (default: `filter')

  --append  -A chain		Append to chain
  --check   -C chain		Check for the existence of a rule
  --delete  -D chain		Delete matching rule from chain

```
```bash 
iptables-save #покажет настройки всех таблиц (в отличие от iptables)
```
```
# показываем текущие соединения
conntrack -L

```

## Сохранение правил в iptables
- Временно:
  - iptables-save > ./iptables.rules
  - iptables-restore < ./iptables.rules
- Постоянно:
  - apt install iptables-persistent netfilter-persistent
  - netfilter-persistent save
  - netfilter-persistent start
  - systemctl status netfilter-persistent.service
    - служба обрабатывает файлы /etc/iptables/rules.v4 (/v6)


## Диагностика прохождения трафика
1. изменить политику по умолчанию на ACCEPT и проверить прохождение
2. проверить в таблицах все правила DROP
3. добавить правило отслеживания:
   - ```iptables -A PREROUTING -t raw -p tcp -j TRACE```
   - и запустить ```xtables-monitior -t```

# IPset
![alt text](image-4.png)



















## Использование списков ipset
- Создать (отдельные IP): ipset -N ddos iphash
- Создать (подсети): ipset create blacklist nethash
- Добавить подсеть: ipset -A ddos 109.95.48.0/21
- Посмотреть список: ipset -L ddos
- Проверить: ipset test ddos 185.174.102.1
- Сохранение: sudo ipset save blacklist -f ipset-blacklist.backup
- Восстановление: sudo ipset restore -! < ipset-blacklist.backup
- Очистка: sudo ipset flush blacklist
- Правило: iptables -I PREROUTING -t raw -m set --match-set ddos src -j DROP
- Сохранение постоянно: apt install ipset-persistent




# Добавление кастомных цепочек
1:25

```bash
# добавить цепочку, определить правила, из таблицы filter сделать перенаправление TARGET на цепочку chain-incoming-ssh
# Определим цепочку для входящего SSH, укажем там только нужные хосты
iptables -N chain-incoming-ssh
iptables -A chain-incoming-ssh -s 192.168.1.148 -j ACCEPT
iptables -A chain-incoming-ssh -s 192.168.122.1 -j ACCEPT
iptables -A chain-incoming-ssh -s 192.168.122.0/24 -j ACCEPT
iptables -A chain-incoming-ssh -j DROP

iptables -I INPUT -p tcp --dport 22 -j chain-incoming-ssh
```