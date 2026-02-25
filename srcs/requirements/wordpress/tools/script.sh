#!/bin/bash

set -e

sleep 3

# Always configure PHP-FPM to listen on TCP port 9000
sed -i 's#listen = /run/php/php8.2-fpm.sock#listen = 9000#' /etc/php/8.2/fpm/pool.d/www.conf

if [ -f /var/www/html/wp-config.php ]
	then
		echo "Wordpress already downloaded ;)"
	else
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

	cd /var/www/html
	wp core download --allow-root
	mv wp-config-sample.php wp-config.php
	
	wp config set DB_NAME "${DB_NAME}" --allow-root
	wp config set DB_USER "${DB_USER}" --allow-root
	wp config set DB_PASSWORD "${DB_PASS}" --allow-root
	wp config set DB_HOST 'mariadb:3306' --allow-root

	wp core install --url=$DOMAIN_NAME --title=inception\
		--admin_user=$WP_ADMIN --admin_password=$WP_ADMINPASS\
		--admin_email=$WP_ADMINEMAIL --allow-root
	wp user create $WP_USER $WP_USEREMAIL --role=author --user_pass=$WP_USERPASS\
		--allow-root

	#---- Redis Configuration ----
	wp config set WP_REDIS_HOST redis --allow-root --path=/var/www/html --type=constant
	wp config set WP_REDIS_PORT 6379 --allow-root --path=/var/www/html --type=constant
	#install and activate the Redis Object Cache plugin
	wp plugin install redis-cache --activate --allow-root --path=/var/www/html
	#enable the Redis cache
	wp redis enable --allow-root --path=/var/www/html
	# verify that the Redis cache is working
	#wp redis status --allow-root -path=/var/www/html
	# ftp
	#FS_METHOD
fi

mkdir -p /run/php
chown -R www-data:www-data /var/www/html
#chmod -R g+w /var/www/html

exec php-fpm8.2 -F