# Less33. OSPF

## Проверка доступности узлов

```bash

# router_id_enable: false
# symmetric_routing: true
#==============================
# router1

root@router1:~# traceroute 192.168.20.10
traceroute to 192.168.20.10 (192.168.20.10), 30 hops max, 60 byte packets
 1  192.168.20.10 (192.168.20.10)  0.954 ms  0.862 ms  0.842 ms
root@router1:~# traceroute 192.168.30.10
traceroute to 192.168.30.10 (192.168.30.10), 30 hops max, 60 byte packets
 1  192.168.30.10 (192.168.30.10)  1.086 ms  1.000 ms  0.980 ms

root@router1:~# vtysh

Hello, this is FRRouting (version 10.3.1).
Copyright 1996-2005 Kunihiro Ishiguro, et al.

router1# show ip route ospf
Codes: K - kernel route, C - connected, L - local, S - static,
       R - RIP, O - OSPF, I - IS-IS, B - BGP, E - EIGRP, N - NHRP,
       T - Table, v - VNC, V - VNC-Direct, A - Babel, F - PBR,
       f - OpenFabric, t - Table-Direct,
       > - selected route, * - FIB route, q - queued, r - rejected, b - backup
       t - trapped, o - offload failure

IPv4 unicast VRF default:
O   10.0.10.0/30 [110/1000] is directly connected, enp0s8, weight 1, 00:45:29
O>* 10.0.11.0/30 [110/200] via 10.0.12.2, enp0s9, weight 1, 00:00:51
O   10.0.12.0/30 [110/100] is directly connected, enp0s9, weight 1, 00:01:00
O   192.168.10.0/24 [110/100] is directly connected, enp0s10, weight 1, 00:45:59
O>* 192.168.20.0/24 [110/1100] via 10.0.10.2, enp0s8, weight 1, 00:44:11
O>* 192.168.30.0/24 [110/200] via 10.0.12.2, enp0s9, weight 1, 00:00:51



# router2
root@router2:~# traceroute 192.168.30.10
traceroute to 192.168.30.10 (192.168.30.10), 30 hops max, 60 byte packets
 1  192.168.30.10 (192.168.30.10)  1.226 ms  0.902 ms  0.642 ms

root@router2:~# vtysh

Hello, this is FRRouting (version 10.3.1).
Copyright 1996-2005 Kunihiro Ishiguro, et al.

router2# show ip route ospf
Codes: K - kernel route, C - connected, L - local, S - static,
       R - RIP, O - OSPF, I - IS-IS, B - BGP, E - EIGRP, N - NHRP,
       T - Table, v - VNC, V - VNC-Direct, A - Babel, F - PBR,
       f - OpenFabric, t - Table-Direct,
       > - selected route, * - FIB route, q - queued, r - rejected, b - backup
       t - trapped, o - offload failure

IPv4 unicast VRF default:
O   10.0.10.0/30 [110/1000] is directly connected, enp0s8, weight 1, 00:42:37
O   10.0.11.0/30 [110/100] is directly connected, enp0s9, weight 1, 00:00:47
O>* 10.0.12.0/30 [110/200] via 10.0.11.1, enp0s9, weight 1, 00:00:38
O>* 192.168.10.0/24 [110/1100] via 10.0.10.1, enp0s8, weight 1, 00:40:49
O   192.168.20.0/24 [110/100] is directly connected, enp0s10, weight 1, 00:42:37
O>* 192.168.30.0/24 [110/200] via 10.0.11.1, enp0s9, weight 1, 00:00:38

root@router2:~# ifconfig enp0s9 down
root@router2:~# vtysh

Hello, this is FRRouting (version 10.3.1).
Copyright 1996-2005 Kunihiro Ishiguro, et al.

router2# show ip route ospf
Codes: K - kernel route, C - connected, L - local, S - static,
       R - RIP, O - OSPF, I - IS-IS, B - BGP, E - EIGRP, N - NHRP,
       T - Table, v - VNC, V - VNC-Direct, A - Babel, F - PBR,
       f - OpenFabric, t - Table-Direct,
       > - selected route, * - FIB route, q - queued, r - rejected, b - backup
       t - trapped, o - offload failure

IPv4 unicast VRF default:
O   10.0.10.0/30 [110/1000] is directly connected, enp0s8, weight 1, 00:44:12
O>* 192.168.10.0/24 [110/1100] via 10.0.10.1, enp0s8, weight 1, 00:42:24
O   192.168.20.0/24 [110/100] is directly connected, enp0s10, weight 1, 00:44:12


```