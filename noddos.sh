#!/bin/bash

#pingcount=0
#timewaitcount=2500
#lastackcount=25
#fincount=300
#establishedcount=200
#synreceivedcount=100

#ban ping
cat /var/log/iptables.log | awk '{print $10}' | awk -F= '{print $2}' | sort | uniq -c | sort -rn | awk '{if ($1>0) print $2}' >/tmp/dropip
for pingban in $(cat /tmp/dropip)
do
/sbin/iptables -I INPUT -s $pingban -j DROP
echo "$pingban pingban kill at `date`" >>/var/log/ddos
done

#ban ddos
netstat -an | grep TIME-WAIT | awk '{print $5}' | awk -F: '{print $1}' | sort | uniq -c | sort -rn | awk '{if ($1>2500) print $2}' >/tmp/dropip
for timewaitban in $(cat /tmp/dropip)
do
/sbin/iptables -I INPUT -s $timewaitban -j DROP
echo "$timewaitban timewaitban kill at `date`" >>/var/log/ddos
done

netstat -an | grep LAST-ACK | awk '{print $5}' | awk -F: '{print $1}' | sort | uniq -c | sort -rn | awk '{if ($1>25) print $2}' >/tmp/dropip
for lastack in $(cat /tmp/dropip)
do
/sbin/iptables -I INPUT -s $lastack -j DROP
echo "$lastack lastack kill at `date`" >>/var/log/ddos
done

netstat -an | grep FIN | awk '{print $5}' | awk -F: '{print $1}' | sort | uniq -c | sort -rn | awk '{if ($1>300) print $2}' >/tmp/dropip
for fin in $(cat /tmp/dropip)
do
/sbin/iptables -I INPUT -s $fin -j DROP
echo "$fin fin kill at `date`" >>/var/log/ddos
done

netstat -an | grep ESTABLISHED | awk '{print $5}' | awk -F: '{print $1}' | sort | uniq -c | sort -rn | awk '{if ($1>200) print $2}' >/tmp/dropip
for established in $(cat /tmp/dropip)
do
/sbin/iptables -I INPUT -s $established -j DROP
echo "$established established kill at `date`" >>/var/log/ddos
done

netstat -an | grep SYN-REC | awk '{print $5}' | awk -F: '{print $1}' | sort | uniq -c | sort -rn | awk '{if ($1>100) print $2}' >/tmp/dropip
for synreceived in $(cat /tmp/dropip)
do
/sbin/iptables -I INPUT -s $synreceived -j DROP
echo "$synreceived synreceived kill at `date`" >>/var/log/ddos
done

service iptables save
rm -rf /tmp/dropip >/dev/null 2>&1 &
rm -rf /var/log/iptables.log >/dev/null 2>&1 &
service rsyslog restart >/dev/null 2>&1 &
