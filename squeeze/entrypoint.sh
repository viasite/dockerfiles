#!/usr/bin/env bash
service bind9 start
service mysql start
service apache2 start
service nginx start
#service ssh start
/usr/sbin/sshd -D
