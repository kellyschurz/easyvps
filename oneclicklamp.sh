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

OLDSERVERNAME="#ServerName www.example.com:80"
NEWSERVERNAME="ServerName localhost:80"
OLDINDEXES="Options Indexes FollowSymLinks"
NEWINDEXES="Options -Indexes FollowSymLinks"
HTTPDCONF="/etc/httpd/conf/httpd.conf"

echo "install httpd mysql mysql-server php php-mysql"
yum -y install httpd mysql mysql-server php php-mysql >/dev/null 2>&1
echo "touch $1"
mkdir /var/www/html/$1
echo "setting httpd.conf"
sed "s/$OLDSERVERNAME/$NEWSERVERNAME/g" -i $HTTPDCONF
sed "s/$OLDINDEXES/$NEWINDEXES/g" -i $HTTPDCONF
echo "NameVirtualHost *:80" >>$HTTPDCONF
echo "<VirtualHost *:80>" >>$HTTPDCONF
echo "DocumentRoot /var/www/html/$1" >>$HTTPDCONF
echo "ServerName $2" >>$HTTPDCONF
echo "</VirtualHost>" >>$HTTPDCONF
echo "setting powerboot"
echo "service httpd start" >>/etc/rc.local
echo "httpd restart"
service httpd restart
