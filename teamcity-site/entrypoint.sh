#!/usr/bin/env bash
set -eu

service mysql start
#service ssh start

grep "0.0.0.0 $SERVICE_NAME" /etc/hosts || {
	echo 0.0.0.0 $SERVICE_NAME >> /etc/hosts
}

if [ -f "/var/www/sql.gz" ]; then
	db_name=$(drush sql-connect | grep -o "\--database=.*\? " | cut -d'=' -f2 | tr -d ' ')
	echo "found /var/www/sql.gz, import db to $db_name"
	mysql_import /var/www/sql.gz "$db_name"
fi

drush runserver $SERVICE_NAME:80

#/usr/sbin/sshd -D
