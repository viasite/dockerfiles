#!/usr/bin/env bash
set -eu

# thanks to https://github.com/rochacon/docker-mysql/blob/master/run
MYSQL_RAM_SIZE=${MYSQL_RAM_SIZE:-"0"}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-"teamcity"}
MYSQL_DATABASE=${MYSQL_DATABASE:-"test"}

SITE_DOMAIN=${SITE_DOMAIN:-$SERVICE_NAME}

if [[ "$MYSQL_RAM_SIZE" != "0" ]]; then
	echo "Mounting MySQL with ${MYSQL_RAM_SIZE}MB of RAM."
	rm -rf /var/lib/mysql
	mkdir -p /var/lib/mysql
	mount -t tmpfs -o size="${MYSQL_RAM_SIZE}m" tmpfs /var/lib/mysql

	chown -R mysql:mysql /var/lib/mysql
	echo "Installing MySQL"
	mysql_install_db --user mysql > /dev/null 2>&1
	#mysqladmin -u root -p'' password "$MYSQL_PASSWORD"

	tfile=$(mktemp)
	if [[ ! -f "$tfile" ]]; then
		return 1
	fi

	cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
UPDATE user SET password=PASSWORD("$MYSQL_PASSWORD") WHERE user='root';
EOF

	if [[ "$MYSQL_DATABASE" != "" ]]; then
		echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile
	fi

	/usr/sbin/mysqld --bootstrap --verbose=0 < $tfile 2>/dev/null
	rm -f $tfile
fi

service mysql start







grep "0.0.0.0 $SITE_DOMAIN" /etc/hosts || {
	echo 0.0.0.0 $SITE_DOMAIN >> /etc/hosts
}

# settings.local.php
if [ ! -f /var/www/sites/default/settings.local.php ]; then
	#chmod 755 /var/www/sites/default
	echo "<?php \$databases['default']['default'] = array('database' => '$MYSQL_DATABASE', 'host' => 'localhost', 'driver' => 'mysql', 'username' => 'root', 'password' => '$MYSQL_PASSWORD');" > "/var/www/sites/default/settings.local.php"
fi

# mysql import
if [ -f "/var/www/sql.gz" ]; then
	#db_name=$(drush sql-connect | grep -o "\--database=.*\? " | cut -d'=' -f2 | tr -d ' ')
	echo "found /var/www/sql.gz, import db to $MYSQL_DATABASE"
	mysql_import /var/www/sql.gz "$MYSQL_DATABASE"
fi


drush runserver $SITE_DOMAIN:80

#/usr/sbin/sshd -D
