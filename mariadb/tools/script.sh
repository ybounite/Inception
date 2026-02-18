#!/bin/bash

set -e

echo "Starting MariaDB initialization..."

service mariadb start

sleep 3

mysqladmin -u root ping > /dev/null 2>&1

mysql -u root << MYSQL_SCRIPT
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

echo "MariaDB initialization complete."

service mariadb stop

mysqld_safe
