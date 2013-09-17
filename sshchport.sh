#!/bin/bash
# Script function : Change ssh port.
# Script version : 1.0
# Author : yoo@yoo.hk
# Made : 2013.09.01
# Support : Only CentOS 6.0+

SSHPATH=/etc/ssh/ssh_config
SSHDPATH=/etc/ssh/sshd_config
ROOTSSHPATH=/root/.ssh/config

sed -i '/Port 22/d' $SSHPATH >>sshsafe.log 2>&1
echo "Port 4399" >> $SSHPATH
sed -i '/Port 22/d' $SSHDPATH >>sshsafe.log 2>&1
echo "Port 4399" >> $SSHDPATH
service sshd restart >>sshsafe.log 2>&1
echo "change ssh port success"

echo "Host github.com" >> $ROOTSSHPATH
echo "HostName github.com" >> $ROOTSSHPATH
echo "Port 22" >> $ROOTSSHPATH
