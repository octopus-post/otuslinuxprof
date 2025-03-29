# Observability base

apt install -y {jnet,h,io,if,a}top iptraf-ng nmon

stress --cpu 4 --io 4 --vm 2 --vm-bytes 1024M --timeout 3600s

uptime
dmesg | tail
vmstat 1
mpstat -P ALL 1
pidstat 1
iostat -xz 1
free -m
sar -n DEV 1
sar -n TCP,ETCP 1
top

cat /proc/loadavg

# Потоки
ps -efL

ps -ef f
ps -eo user,sz,rss,minflt,majflt,pcpu,args

vmstat -Sm 1

strace -tttT -p 27754

# Запись пакетов целиком
tcpdump -s0 -i any -w /tmp/out.pcap

# Socket stat
ss -s

# Статистика по сетевым интерфейсам
nicstat

# Swap
swapon -s

# Открытые файловые дескрипторы
lsof -iTCP -sTCP:ESTABLISHED

# SAR
systemctl status sysstat
sar -n TCP,ETCP,DEV 1

# Нагрузка на диски по процессам
iotop

# display kernel slab cache information in real time
slabtop

# Аппаратные счетчики (на реальном CPU)
tiptop

##################### Tuning #########################################

cat /proc/cpuinfo

dmesg

df -h

numactl -s

lspci

lsmod

crontab -l

systemctl --status-all

