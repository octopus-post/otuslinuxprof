#!/usr/bash

logfile=$1
verifile='./donottouch'

function f_getfile (){
	if [ -f $1 ]; then echo 0
	else echo 2
	fi
}
if [ -z $1 ] ; then
	echo 'Не передан параметр. Операция прервана'
	exit 1
fi
if [ $(f_getfile ${logfile}) != 0 ]; then
	echo 'Не найден файл лога. Операция прервана.'
	exit 1
fi

if [ $(f_getfile ${verifile}) == 0 ]; then
		echo 'Нельзя запускать одновременно две версии скрипта.\nОперация прервана.'
		exit 2
fi
# формат даты и времени [14/Aug/2019:12:59:50 +0300]
#path_tonginx_log='/var/log/nginx'
path_tolog_lashour='/opt/nginx_logs/logs'
f_log_lasthour=${path_tolog_lashour}/access_$(date -d'-1 hours' +%d_%b_%Y-%H-%M).log

touch ${verifile}

# копировать строки за последний час из лога во временный файл
awk -vcurDate=$(date -d'-1 hours' +[%d/%b/%Y:%H:%M:%S) ' { if ($4 > curDate) print $0}' ${logfile} > ${f_log_lasthour}
echo "********IP***********"
awk '/GET/{print $9,$6,$1}' ${f_log_lasthour} | sort -n | uniq -cd | sort -nr | head -n20 > ${path_tolog_lashour}/get_log_GET
echo "********URL***********"
awk '{print $7}' ${logfile} | sort -n | uniq -cd | sort -nr | head -n20 > ${path_tolog_lashour}/get_log_URL
echo "********ERR***********"
awk '{print $9}' ${logfile} | awk '/[4|5][0-9][0-9]/{print $0}' | sort -n | uniq -cd | sort -nr > ${path_tolog_lashour}/get_log_ERR
echo "********CODE***********"
awk '{print $9}' ${logfile} | sort -n | uniq -cd | sort -nr | head -n10 > ${path_tolog_lashour}/get_log_CODE

#===========
# отправить сообщение администратору, mailutils
header="Логи вебсервера $HOSTNAME. $(date)"
substr="Юстас - Алексу. Результат работы веб-сервера $HOSTNAME.\n Логи во вложении.\n Период с $(date -d'-1 hours' +%d/%b/%Y:%H:%M) по $(date +%d/%b/%Y:%H:%M)" 
recip='root'
mail -s ${header} -A path_tolog_lashour/get_log_GET -A path_tolog_lashour/get_log_URL -A path_tolog_lashour/get_log_ERR -A path_tolog_lashour/get_log_CODE ${recip} <<< ${substr}


rm -f ${verifile}
echo 'Операция завершена'
