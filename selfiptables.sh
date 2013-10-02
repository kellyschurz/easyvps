#!/bin/bash
# Script function : local iptables.
# Script version : 1.0
# Author : yoo@yoo.hk
# Made : 2013.09.27
# Support : Only CentOS 6.0+

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
LANG=C

export PATH
export LANG

yum install -y iptables >>setiptables.log 2>&1
iptables -F
iptables -X
iptables -Z
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -p icmp --icmp-type ping -j DROP
service iptables save 
service iptables restart
