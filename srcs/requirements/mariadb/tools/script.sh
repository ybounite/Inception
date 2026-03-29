#!/bin/bash

set -e

echo "Starting MariaDB initialization..."

service mariadb start

#Wait Until MariaDB Is Ready
until mysqladmin ping --silent; do
    sleep 1
done

mysqladmin -u root ping > /dev/null 2>&1

mysql -u root << MYSQL_SCRIPT
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

echo "MariaDB initialization complete."

service mariadb stop

exec mysqld --user=mysql --bind-address=0.0.0.0