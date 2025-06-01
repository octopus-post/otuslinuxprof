# Less35. VPN

## Команды и вывод результатов
- [Less35. VPN](#less35-vpn)
  - [Команды и вывод результатов](#команды-и-вывод-результатов)
  - [1. TUN/TAP режимы VPN](#1-tuntap-режимы-vpn)
    - [Openvpn в режиме TAP](#openvpn-в-режиме-tap)
      - [Конфигурация openvpn на сервере](#конфигурация-openvpn-на-сервере)
      - [Конфигурация openvpn на клиенте](#конфигурация-openvpn-на-клиенте)
      - [Результаты измерения скорости утилитой iperf3 на сервере](#результаты-измерения-скорости-утилитой-iperf3-на-сервере)
    - [Openvpn в режиме TUN](#openvpn-в-режиме-tun)
      - [Конфигурация openvpn на сервере](#конфигурация-openvpn-на-сервере-1)
      - [Конфигурация openvpn на клиенте](#конфигурация-openvpn-на-клиенте-1)
      - [Результаты измерения скорости утилитой iperf3 на сервере](#результаты-измерения-скорости-утилитой-iperf3-на-сервере-1)
  - [2. RAS OpenVPN](#2-ras-openvpn)

======================================================================================
## 1. TUN/TAP режимы VPN
### Openvpn в режиме TAP


#### Конфигурация openvpn на сервере
```bash
root@server:~# cat /etc/openvpn/server.conf 
dev tap
ifconfig 10.10.10.1 255.255.255.0 
topology subnet 
secret /etc/openvpn/static.key 
comp-lzo 
status /var/log/openvpn/openvpn-status.log 
log /var/log/openvpn/openvpn.log  
verb 3

root@server:~# systemctl status openvpn@server.service
● openvpn@server.service - OpenVPN Tunneling Application On server
     Loaded: loaded (/etc/systemd/system/openvpn@.service; enabled; vendor preset: enabled)
     Active: active (running) since Sun 2025-06-01 13:02:11 UTC; 6min ago
   Main PID: 4174 (openvpn)
     Status: "Initialization Sequence Completed"
      Tasks: 1 (limit: 1102)
     Memory: 1.6M
        CPU: 33.043s
     CGroup: /system.slice/system-openvpn.slice/openvpn@server.service
             └─4174 /usr/sbin/openvpn --cd /etc/openvpn/ --config server.conf

Jun 01 13:02:11 server systemd[1]: Starting OpenVPN Tunneling Application On server...
Jun 01 13:02:11 server openvpn[4174]: 2025-06-01 13:02:11 WARNING: Compression for receiving enabled. Compression has been used in the past to break >
Jun 01 13:02:11 server systemd[1]: Started OpenVPN Tunneling Application On server.

```

#### Конфигурация openvpn на клиенте
```bash 
root@client:~# cat /etc/openvpn/server.conf
dev tap
 
remote 192.168.56.10
route 192.168.56.0 255.255.255.0
ifconfig 10.10.10.2 255.255.255.0 
topology subnet 
secret /etc/openvpn/static.key 
comp-lzo 
status /var/log/openvpn/openvpn-status.log 
log /var/log/openvpn/openvpn.log  
verb 3

root@client:~# systemctl status openvpn@server.service 
● openvpn@server.service - OpenVPN Tunneling Application On server
     Loaded: loaded (/etc/systemd/system/openvpn@.service; enabled; vendor preset: enabled)
     Active: active (running) since Sun 2025-06-01 13:02:11 UTC; 5min ago
   Main PID: 4238 (openvpn)
     Status: "Initialization Sequence Completed"
      Tasks: 1 (limit: 1102)
     Memory: 1.6M
        CPU: 37.707s
     CGroup: /system.slice/system-openvpn.slice/openvpn@server.service
             └─4238 /usr/sbin/openvpn --cd /etc/openvpn/ --config server.conf

Jun 01 13:02:11 client systemd[1]: Starting OpenVPN Tunneling Application On server...
Jun 01 13:02:11 client openvpn[4238]: 2025-06-01 13:02:11 WARNING: Compression for receiving enabled. Compression has been used in the past to break >
Jun 01 13:02:11 client systemd[1]: Started OpenVPN Tunneling Application On server.

```

#### Результаты измерения скорости утилитой iperf3 на сервере

```bash 
root@server:~# iperf3 -s
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.10.10.2, port 34766
[  5] local 10.10.10.1 port 5201 connected to 10.10.10.2 port 34776
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  9.53 MBytes  80.0 Mbits/sec                  
[  5]   1.00-2.00   sec  10.4 MBytes  86.9 Mbits/sec                  
[  5]   2.00-3.00   sec  15.6 MBytes   131 Mbits/sec                  
[  5]   3.00-4.00   sec  16.5 MBytes   139 Mbits/sec                  
[  5]   4.00-5.00   sec  17.4 MBytes   146 Mbits/sec                  
[  5]   5.00-6.00   sec  17.5 MBytes   147 Mbits/sec                  
[  5]   6.00-7.00   sec  16.7 MBytes   140 Mbits/sec                  
[  5]   7.00-8.00   sec  11.5 MBytes  96.4 Mbits/sec                  
[  5]   8.00-9.00   sec  9.56 MBytes  80.2 Mbits/sec                  
[  5]   9.00-10.00  sec  9.72 MBytes  81.5 Mbits/sec                  
[  5]  10.00-11.00  sec  10.0 MBytes  83.9 Mbits/sec                  
[  5]  11.00-12.00  sec  11.3 MBytes  94.9 Mbits/sec                  
[  5]  12.00-13.00  sec  12.8 MBytes   107 Mbits/sec                  
[  5]  13.00-14.00  sec  14.5 MBytes   122 Mbits/sec                  
[  5]  14.00-15.00  sec  13.1 MBytes   110 Mbits/sec                  
[  5]  15.00-16.00  sec  9.22 MBytes  77.4 Mbits/sec                  
[  5]  16.00-17.00  sec  10.5 MBytes  88.3 Mbits/sec                  
[  5]  17.00-18.00  sec  10.5 MBytes  87.7 Mbits/sec                  
[  5]  18.00-19.00  sec  10.9 MBytes  91.2 Mbits/sec                  
[  5]  19.00-20.00  sec  11.0 MBytes  92.6 Mbits/sec                  
[  5]  20.00-21.00  sec  11.0 MBytes  92.3 Mbits/sec                  
[  5]  21.00-22.00  sec  10.7 MBytes  90.0 Mbits/sec                  
[  5]  22.00-23.00  sec  10.7 MBytes  90.0 Mbits/sec                  
[  5]  23.00-24.00  sec  9.96 MBytes  83.5 Mbits/sec                  
[  5]  24.00-25.00  sec  10.5 MBytes  87.7 Mbits/sec                  
[  5]  25.00-26.00  sec  9.49 MBytes  79.6 Mbits/sec                  
[  5]  26.00-27.00  sec  11.8 MBytes  99.2 Mbits/sec                  
[  5]  27.00-28.00  sec  17.2 MBytes   144 Mbits/sec                  
[  5]  28.00-29.00  sec  15.3 MBytes   128 Mbits/sec                  
[  5]  29.00-30.00  sec  17.2 MBytes   144 Mbits/sec                  
[  5]  30.00-31.00  sec  16.5 MBytes   139 Mbits/sec                  
[  5]  31.00-32.00  sec  16.9 MBytes   142 Mbits/sec                  
[  5]  32.00-33.00  sec  17.9 MBytes   150 Mbits/sec                  
[  5]  33.00-34.00  sec  17.2 MBytes   145 Mbits/sec                  
[  5]  34.00-35.00  sec  14.8 MBytes   124 Mbits/sec                  
[  5]  35.00-36.00  sec  10.3 MBytes  86.8 Mbits/sec                  
[  5]  36.00-37.00  sec  11.0 MBytes  92.4 Mbits/sec                  
[  5]  37.00-38.00  sec  16.2 MBytes   136 Mbits/sec                  
[  5]  38.00-39.00  sec  15.1 MBytes   126 Mbits/sec                  
[  5]  39.00-40.00  sec  15.3 MBytes   129 Mbits/sec                  
[  5]  40.00-40.05  sec   424 KBytes  68.5 Mbits/sec                  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-40.05  sec   524 MBytes   110 Mbits/sec                  receiver
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
^Ciperf3: interrupt - the server has terminated


root@client:~# iperf3 -c 10.10.10.1 -t 40 -i 5 
Connecting to host 10.10.10.1, port 5201
[  5] local 10.10.10.2 port 34776 connected to 10.10.10.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-5.00   sec  71.2 MBytes   119 Mbits/sec  121    183 KBytes       
[  5]   5.00-10.00  sec  64.6 MBytes   108 Mbits/sec   55    119 KBytes       
[  5]  10.00-15.00  sec  61.9 MBytes   104 Mbits/sec   30    133 KBytes       
[  5]  15.00-20.00  sec  52.2 MBytes  87.6 Mbits/sec   68    123 KBytes       
[  5]  20.00-25.00  sec  52.7 MBytes  88.3 Mbits/sec   59    115 KBytes       
[  5]  25.00-30.00  sec  71.1 MBytes   119 Mbits/sec   56    168 KBytes       
[  5]  30.00-35.00  sec  83.5 MBytes   140 Mbits/sec   91    159 KBytes       
[  5]  35.00-40.00  sec  67.9 MBytes   114 Mbits/sec   41    138 KBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-40.00  sec   525 MBytes   110 Mbits/sec  521             sender
[  5]   0.00-40.05  sec   524 MBytes   110 Mbits/sec                  receiver

iperf Done.

```
======================================================================================
### Openvpn в режиме TUN


#### Конфигурация openvpn на сервере
```bash
root@server:~# cat /etc/openvpn/server.conf 
dev tun
ifconfig 10.10.10.1 255.255.255.0 
topology subnet 
secret /etc/openvpn/static.key 
comp-lzo 
status /var/log/openvpn/openvpn-status.log 
log /var/log/openvpn/openvpn.log  
verb 3
```

#### Конфигурация openvpn на клиенте
```bash 
root@client:~# cat /etc/openvpn/server.conf
dev tun
 
remote 192.168.56.10
route 192.168.56.0 255.255.255.0
ifconfig 10.10.10.2 255.255.255.0 
topology subnet 
secret /etc/openvpn/static.key 
comp-lzo 
status /var/log/openvpn/openvpn-status.log 
log /var/log/openvpn/openvpn.log  
verb 3
```

===============================================================================
#### Результаты измерения скорости утилитой iperf3 на сервере
```bash
root@server:~# iperf3 -s
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.10.10.2, port 54002
[  5] local 10.10.10.1 port 5201 connected to 10.10.10.2 port 54014
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  8.88 MBytes  74.5 Mbits/sec                  
[  5]   1.00-2.00   sec  9.07 MBytes  76.1 Mbits/sec                  
[  5]   2.00-3.00   sec  10.4 MBytes  87.4 Mbits/sec                  
[  5]   3.00-4.00   sec  9.54 MBytes  80.0 Mbits/sec                  
[  5]   4.00-5.00   sec  9.47 MBytes  79.5 Mbits/sec                  
[  5]   5.00-6.00   sec  9.57 MBytes  80.3 Mbits/sec                  
[  5]   6.00-7.00   sec  10.5 MBytes  87.8 Mbits/sec                  
[  5]   7.00-8.00   sec  11.0 MBytes  92.0 Mbits/sec                  
[  5]   8.00-9.00   sec  9.65 MBytes  80.9 Mbits/sec                  
[  5]   9.00-10.00  sec  9.21 MBytes  77.2 Mbits/sec                  
[  5]  10.00-11.00  sec  9.52 MBytes  79.8 Mbits/sec                  
[  5]  11.00-12.00  sec  9.37 MBytes  78.6 Mbits/sec                  
[  5]  12.00-13.00  sec  9.51 MBytes  79.8 Mbits/sec                  
[  5]  13.00-14.00  sec  9.49 MBytes  79.6 Mbits/sec                  
[  5]  14.00-15.00  sec  10.2 MBytes  85.2 Mbits/sec                  
[  5]  15.00-16.00  sec  10.0 MBytes  84.0 Mbits/sec                  
[  5]  16.00-17.00  sec  10.5 MBytes  87.9 Mbits/sec                  
[  5]  17.00-18.00  sec  9.66 MBytes  81.0 Mbits/sec                  
[  5]  18.00-19.00  sec  9.71 MBytes  81.5 Mbits/sec                  
[  5]  19.00-20.00  sec  9.56 MBytes  80.2 Mbits/sec                  
[  5]  20.00-21.00  sec  9.55 MBytes  80.1 Mbits/sec                  
[  5]  21.00-22.00  sec  9.90 MBytes  83.1 Mbits/sec                  
[  5]  22.00-23.00  sec  10.6 MBytes  88.6 Mbits/sec                  
[  5]  23.00-24.00  sec  9.22 MBytes  77.3 Mbits/sec                  
[  5]  24.00-25.00  sec  9.54 MBytes  80.1 Mbits/sec                  
[  5]  25.00-26.00  sec  9.69 MBytes  81.3 Mbits/sec                  
[  5]  26.00-27.00  sec  8.11 MBytes  68.1 Mbits/sec                  
[  5]  27.00-28.00  sec  7.69 MBytes  64.5 Mbits/sec                  
[  5]  28.00-29.00  sec  7.63 MBytes  64.0 Mbits/sec                  
[  5]  29.00-30.00  sec  8.91 MBytes  74.6 Mbits/sec                  
[  5]  30.00-31.00  sec  7.75 MBytes  65.1 Mbits/sec                  
[  5]  31.00-32.00  sec  7.92 MBytes  66.4 Mbits/sec                  
[  5]  32.00-33.00  sec  8.48 MBytes  71.1 Mbits/sec                  
[  5]  33.00-34.00  sec  7.66 MBytes  64.3 Mbits/sec                  
[  5]  34.00-35.00  sec  8.60 MBytes  72.2 Mbits/sec                  
[  5]  35.00-36.00  sec  9.80 MBytes  82.2 Mbits/sec                  
[  5]  36.00-37.00  sec  10.6 MBytes  88.6 Mbits/sec                  
[  5]  37.00-38.00  sec  10.1 MBytes  85.0 Mbits/sec                  
[  5]  38.00-39.00  sec  9.36 MBytes  78.5 Mbits/sec                  
[  5]  39.00-40.00  sec  9.63 MBytes  80.8 Mbits/sec                  
[  5]  40.00-40.08  sec   568 KBytes  60.6 Mbits/sec                  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-40.08  sec   376 MBytes  78.7 Mbits/sec                  receiver
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------

root@client:~# iperf3 -c 10.10.10.1 -t 40 -i 5 
Connecting to host 10.10.10.1, port 5201
[  5] local 10.10.10.2 port 54014 connected to 10.10.10.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-5.00   sec  48.4 MBytes  81.3 Mbits/sec   17    168 KBytes       
[  5]   5.00-10.00  sec  49.9 MBytes  83.6 Mbits/sec   44    200 KBytes       
[  5]  10.00-15.00  sec  48.5 MBytes  81.4 Mbits/sec  153    101 KBytes       
[  5]  15.00-20.00  sec  49.2 MBytes  82.6 Mbits/sec   35    146 KBytes       
[  5]  20.00-25.00  sec  48.8 MBytes  81.9 Mbits/sec   77    134 KBytes       
[  5]  25.00-30.00  sec  41.8 MBytes  70.1 Mbits/sec   54    117 KBytes       
[  5]  30.00-35.00  sec  40.6 MBytes  68.0 Mbits/sec   38    128 KBytes       
[  5]  35.00-40.00  sec  49.4 MBytes  82.8 Mbits/sec   27    146 KBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-40.00  sec   377 MBytes  79.0 Mbits/sec  445             sender
[  5]   0.00-40.08  sec   376 MBytes  78.7 Mbits/sec                  receiver

iperf Done.
```


======================================================================================

## 2. RAS OpenVPN


```bash
# проверка доступности сервера openvpn с хостовой машины
 ╭─alex@smith in /etc/openvpn🔒 took 0s
 ╰─λ ping 10.10.10.101
PING 10.10.10.101 (10.10.10.101) 56(84) bytes of data.
64 bytes from 10.10.10.101: icmp_seq=1 ttl=64 time=0.058 ms
64 bytes from 10.10.10.101: icmp_seq=2 ttl=64 time=0.049 ms
64 bytes from 10.10.10.101: icmp_seq=3 ttl=64 time=0.046 ms
64 bytes from 10.10.10.101: icmp_seq=4 ttl=64 time=0.045 ms
64 bytes from 10.10.10.101: icmp_seq=5 ttl=64 time=0.045 ms
64 bytes from 10.10.10.101: icmp_seq=6 ttl=64 time=0.043 ms
^C
--- 10.10.10.101 ping statistics ---
6 packets transmitted, 6 received, 0% packet loss, time 5056ms
rtt min/avg/max/mdev = 0.043/0.047/0.058/0.005 ms

 ╭─alex@smith in /etc/openvpn🔒 took 9m23s
 ╰─λ traceroute 10.10.10.1
traceroute to 10.10.10.1 (10.10.10.1), 30 hops max, 60 byte packets
 1  10.10.10.1 (10.10.10.1)  1.219 ms  1.223 ms  1.224 ms

```