# DNS: настройка и обслуживание

## 1. Работа со стендом и настройка DNS

```bash
# открытые порты на сервере ns01
root@ns01:~# ss -tulpn
Netid   State    Recv-Q   Send-Q                            Local Address:Port      Peer Address:Port   Process                                       
udp     UNCONN   0        0                                 192.168.56.10:53             0.0.0.0:*       users:(("named",pid=6293,fd=36))             
udp     UNCONN   0        0                                 192.168.56.10:53             0.0.0.0:*       users:(("named",pid=6293,fd=35))             
udp     UNCONN   0        0                                     10.0.2.15:53             0.0.0.0:*       users:(("named",pid=6293,fd=32))             
udp     UNCONN   0        0                                     10.0.2.15:53             0.0.0.0:*       users:(("named",pid=6293,fd=31))             
udp     UNCONN   0        0                                     127.0.0.1:53             0.0.0.0:*       users:(("named",pid=6293,fd=26))             
udp     UNCONN   0        0                                     127.0.0.1:53             0.0.0.0:*       users:(("named",pid=6293,fd=25))             
udp     UNCONN   0        0                                 127.0.0.53%lo:53             0.0.0.0:*       users:(("systemd-resolve",pid=544,fd=13))    
udp     UNCONN   0        0                              10.0.2.15%enp0s3:68             0.0.0.0:*       users:(("systemd-network",pid=1786,fd=18))   
udp     UNCONN   0        0                                 192.168.56.10:123            0.0.0.0:*       users:(("ntpd",pid=3089,fd=20))              
udp     UNCONN   0        0                                     10.0.2.15:123            0.0.0.0:*       users:(("ntpd",pid=3089,fd=19))              
udp     UNCONN   0        0                                     127.0.0.1:123            0.0.0.0:*       users:(("ntpd",pid=3089,fd=18))              
udp     UNCONN   0        0                                       0.0.0.0:123            0.0.0.0:*       users:(("ntpd",pid=3089,fd=17))              
udp     UNCONN   0        0                                         [::1]:53                [::]:*       users:(("named",pid=6293,fd=39))             
udp     UNCONN   0        0                                         [::1]:53                [::]:*       users:(("named",pid=6293,fd=40))        

# открытые порты на сервере ns02
root@ns02:~# ss -tulpn
Netid   State    Recv-Q   Send-Q                            Local Address:Port      Peer Address:Port   Process                                       
udp     UNCONN   0        0                                 192.168.56.11:53             0.0.0.0:*       users:(("named",pid=8183,fd=36))             
udp     UNCONN   0        0                                 192.168.56.11:53             0.0.0.0:*       users:(("named",pid=8183,fd=35))             
udp     UNCONN   0        0                                     10.0.2.15:53             0.0.0.0:*       users:(("named",pid=8183,fd=32))             
udp     UNCONN   0        0                                     10.0.2.15:53             0.0.0.0:*       users:(("named",pid=8183,fd=31))             
udp     UNCONN   0        0                                     127.0.0.1:53             0.0.0.0:*       users:(("named",pid=8183,fd=26))             
udp     UNCONN   0        0                                     127.0.0.1:53             0.0.0.0:*       users:(("named",pid=8183,fd=25))             
udp     UNCONN   0        0                                 127.0.0.53%lo:53             0.0.0.0:*       users:(("systemd-resolve",pid=543,fd=13))    
udp     UNCONN   0        0                              10.0.2.15%enp0s3:68             0.0.0.0:*       users:(("systemd-network",pid=1786,fd=18))   
udp     UNCONN   0        0                                 192.168.56.11:123            0.0.0.0:*       users:(("ntpd",pid=3035,fd=20))              
udp     UNCONN   0        0                                     10.0.2.15:123            0.0.0.0:*       users:(("ntpd",pid=3035,fd=19))              
udp     UNCONN   0        0                                     127.0.0.1:123            0.0.0.0:*       users:(("ntpd",pid=3035,fd=18))              
udp     UNCONN   0        0                                       0.0.0.0:123            0.0.0.0:*       users:(("ntpd",pid=3035,fd=17))              
udp     UNCONN   0        0                                         [::1]:53                [::]:*       users:(("named",pid=8183,fd=39))             
udp     UNCONN   0        0                                         [::1]:53                [::]:*       users:(("named",pid=8183,fd=40))             

```
```bash
# проверка с клиента на ns01
root@client:~# dig @192.168.56.10 web1.dns.lab

; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> @192.168.56.10 web1.dns.lab
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 49171
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 22e2576f3aa37ef8010000006845bcf94d0e5931fea2fe32 (good)
;; QUESTION SECTION:
;web1.dns.lab.			IN	A

;; ANSWER SECTION:
web1.dns.lab.		3600	IN	A	192.168.56.15

;; Query time: 3 msec
;; SERVER: 192.168.56.10#53(192.168.56.10) (UDP)
;; WHEN: Sun Jun 08 16:40:25 UTC 2025
;; MSG SIZE  rcvd: 85

# проверка с клиента на ns02
root@client:~# dig @192.168.56.11 web2.dns.lab

; <<>> DiG 9.18.30-0ubuntu0.22.04.2-Ubuntu <<>> @192.168.56.11 web2.dns.lab
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 54187
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 4df8c6e312002dec010000006845bd4ed2247a0cee214de3 (good)
;; QUESTION SECTION:
;web2.dns.lab.			IN	A

;; ANSWER SECTION:
web2.dns.lab.		3600	IN	A	192.168.56.16

;; Query time: 0 msec
;; SERVER: 192.168.56.11#53(192.168.56.11) (UDP)
;; WHEN: Sun Jun 08 16:41:50 UTC 2025
;; MSG SIZE  rcvd: 85


```

## 2. Настройка Split-DNS 

```bash
# проверка с хоста client
# не доступна только зона web2.dns.lab
root@client:~# ping www.newdns.lab
PING www.newdns.lab (192.168.56.15) 56(84) bytes of data.
64 bytes from 192.168.56.15 (192.168.56.15): icmp_seq=1 ttl=64 time=0.046 ms
64 bytes from 192.168.56.15 (192.168.56.15): icmp_seq=2 ttl=64 time=0.063 ms
64 bytes from 192.168.56.15 (192.168.56.15): icmp_seq=3 ttl=64 time=0.058 ms
^C
--- www.newdns.lab ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2004ms
rtt min/avg/max/mdev = 0.046/0.055/0.063/0.007 ms

root@client:~# ping web1.dns.lab
PING web1.dns.lab (192.168.56.15) 56(84) bytes of data.
64 bytes from 192.168.56.15 (192.168.56.15): icmp_seq=1 ttl=64 time=0.049 ms
64 bytes from 192.168.56.15 (192.168.56.15): icmp_seq=2 ttl=64 time=0.062 ms
64 bytes from 192.168.56.15 (192.168.56.15): icmp_seq=3 ttl=64 time=0.064 ms
^C
--- web1.dns.lab ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 0.049/0.058/0.064/0.006 ms

root@client:~# ping web2.dns.lab
ping: web2.dns.lab: Name or service not known

```
```bash
# проверка с хоста client2
# не доступна только зона newdns.lab
root@client2:~# ping www.newdns.lab
ping: www.newdns.lab: Name or service not known

root@client2:~# ping web1.dns.lab
PING web1.dns.lab (192.168.56.15) 56(84) bytes of data.
64 bytes from 192.168.56.15 (192.168.56.15): icmp_seq=1 ttl=64 time=1.02 ms
64 bytes from 192.168.56.15 (192.168.56.15): icmp_seq=2 ttl=64 time=0.458 ms
64 bytes from 192.168.56.15 (192.168.56.15): icmp_seq=3 ttl=64 time=0.483 ms
^C
--- web1.dns.lab ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2075ms
rtt min/avg/max/mdev = 0.458/0.652/1.016/0.257 ms

root@client2:~# ping web2.dns.lab
PING web2.dns.lab (192.168.56.16) 56(84) bytes of data.
64 bytes from 192.168.56.16 (192.168.56.16): icmp_seq=1 ttl=64 time=0.048 ms
64 bytes from 192.168.56.16 (192.168.56.16): icmp_seq=2 ttl=64 time=0.060 ms
64 bytes from 192.168.56.16 (192.168.56.16): icmp_seq=3 ttl=64 time=0.182 ms
^C
--- web2.dns.lab ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 3600ms
rtt min/avg/max/mdev = 0.048/0.096/0.182/0.060 ms

```

#### ==============================================
dig
```bash    
    dig @anuj.cloudflare.com  otus.ru A|NS|MX
    dig +trace www.otus.ru
```
hosts

nslookup

1:08 дз
1:46 вопросы


