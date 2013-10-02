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

echo "kern.warning /var/log/iptables.log" >>/etc/rsyslog.conf
echo "*/10  *  *  *  * root sh /root/easyvps/noddos.sh" >>/etc/crontab
echo "*  */6  *  *  * root sh /root/easyvps/setiptables.sh" >>/etc/crontab
service iptables restart >/dev/null 2>&1 &
service crond restart >/dev/null 2>&1 &
