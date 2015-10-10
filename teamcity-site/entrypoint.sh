#!/usr/bin/env bash
set -eu

service mysql start
#service ssh start

grep "0.0.0.0 $SERVICE_NAME" /etc/hosts || {
	echo 0.0.0.0 $SERVICE_NAME >> /etc/hosts
}

db_name="test"
# settings.local.php
if [ ! -f /var/www/sites/default/settings.local.php ]; then
	#chmod 755 /var/www/sites/default
	echo "<?php \$databases['default']['default'] = array('database' => '$db_name', 'host' => 'localhost', 'driver' => 'mysql', 'username' => 'root', 'password' => 'teamcity');" > "/var/www/sites/default/settings.local.php"
fi

# mysql import
if [ -f "/var/www/sql.gz" ]; then
	#db_name=$(drush sql-connect | grep -o "\--database=.*\? " | cut -d'=' -f2 | tr -d ' ')
	echo "found /var/www/sql.gz, import db to $db_name"
	mysql_import /var/www/sql.gz "$db_name"
fi


drush runserver $SERVICE_NAME:80

#/usr/sbin/sshd -D
