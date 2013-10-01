#!/bin/bash
yum install -y iptables >>setiptables.log 2>&1
iptables -F
iptables -X
iptables -Z
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p tcp -m multiport --dports 4399,53,12345,80 -j ACCEPT
iptables -A INPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type ping -j LOG
iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -p icmp --icmp-type ping -j DROP
service iptables save
service iptables restart
echo "kern.warning /var/log/iptables.log" >>/etc/rsyslog.conf
echo "*/5  *  *  *  * root /root/easyvps/noddos.sh" >>/etc/crontab
echo "*  */6  *  *  * root service iptables restart" >>/etc/crontab
service iptables restart
service crond restart
