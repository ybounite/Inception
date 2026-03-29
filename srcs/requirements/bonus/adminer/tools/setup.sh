#!/bin/bash
set -e

mkdir -p /var/www/html

wget -O /var/www/html/index.php https://www.adminer.org/latest.php

chown -R www-data:www-data /var/www/html
chmod 755 /var/www/html/index.php

rm -f /var/www/html/index.html

cd /var/www/html
php -S 0.0.0.0:80