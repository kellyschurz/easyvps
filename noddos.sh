#!/bin/bash
# Script function : auto no ddos.
# Script version : 1.0
# Author : yoo@yoo.hk
# Made : 2013.09.27
# Support : Only CentOS 6.0+

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
LANG=C

export PATH
export LANG

SERVERIP=$(ifconfig | grep "inet addr" | awk '{print $2}'| cut -d ':' -f 2 | grep -v 127.0.0 | head -n 1)

function sedsomeip()
{
 sed -i '/127\.0\.0\.1/d' /tmp/dropip
 sed -i '/$SERVERIP/d' /tmp/dropip
 sed -i '/0\.0\.0\.0/d' /tmp/dropip
}

#ban ping > 5
 cat /var/log/iptables.log | awk '{print $10}' | awk -F= '{print $2}' | sort | uniq -c | sort -rn | awk '{if ($1>5) print $2}' >/tmp/dropip
sedsomeip
for pingban in $(cat /tmp/dropip)
do
iptables -I INPUT -s $pingban -j DROP
echo "$pingban pingban kill at `date`" >>/var/log/ddos
done

#ban time wait ddos > 2500
netstat -an | grep TIME_WAIT | awk '{print $5}' | awk -F: '{print $4}' | sort | uniq -c | sort -rn | awk '{if ($1>2500) print $2}' >/tmp/dropip
sedsomeip
for timewaitban in $(cat /tmp/dropip)
do
iptables -I INPUT -s $timewaitban -j DROP
echo "$timewaitban timewaitban kill at `date`" >>/var/log/ddos
done

#ban established ddos > 200
netstat -an | grep ESTABLISHED | awk '{print $5}' | awk -F: '{print $1}' | sort | uniq -c | sort -rn | awk '{if ($1>200) print $2}' >/tmp/dropip
sedsomeip
for established in $(cat /tmp/dropip)
do
iptables -I INPUT -s $established -j DROP
echo "$established established kill at `date`" >>/var/log/ddos
done

#netstat -an | grep SYN_REC | awk '{print $5}' | awk -F: '{print $1}' | sort | uniq -c | sort -rn | awk '{if ($1>100) print $2}' >/tmp/dropip
#for synreceived in $(cat /tmp/dropip)
#do
#iptables -I INPUT -s $synreceived -j DROP
#echo "$synreceived synreceived kill at `date`" >>/var/log/ddos
#done

#netstat -an | grep LAST_ACK | awk '{print $5}' | awk -F: '{print $1}' | sort | uniq -c | sort -rn | awk '{if ($1>25) print $2}' >/tmp/dropip
#for lastack in $(cat /tmp/dropip)
#do
#iptables -I INPUT -s $lastack -j DROP
#echo "$lastack lastack kill at `date`" >>/var/log/ddos
#done

#netstat -an | grep FIN | awk '{print $5}' | awk -F: '{print $1}' | sort | uniq -c | sort -rn | awk '{if ($1>300) print $2}' >/tmp/dropip
#for fin in $(cat /tmp/dropip)
#do
#iptables -I INPUT -s $fin -j DROP
#echo "$fin fin kill at `date`" >>/var/log/ddos
#done

service iptables save
rm -rf /tmp/dropip >/dev/null 2>&1 &
rm -rf /var/log/iptables.log >/dev/null 2>&1 &
service rsyslog restart >/dev/null 2>&1 &
