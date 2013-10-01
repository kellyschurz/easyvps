#!/bin/bash
echo "kern.warning /var/log/iptables.log" >>/etc/rsyslog.conf
echo "*/1  *  *  *  * root sh /root/easyvps/noddos.sh" >>/etc/crontab
echo "*  */6  *  *  * root sh /root/easyvps/setiptables.sh" >>/etc/crontab
service iptables restart
service crond restart
