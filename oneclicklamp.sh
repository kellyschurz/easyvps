#!/bin/bash
# Script function : one click to install LAMP
# Script version : 1.0
# Author : yoo@yoo.hk
# Made : 2013.09.27
# Support : Only CentOS 6.0+

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
LANG=C

export PATH
export LANG

yum install httpd mysql mysql-server php php-mysql >/dev/null 2>&1

