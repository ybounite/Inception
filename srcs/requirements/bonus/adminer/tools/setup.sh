#!/bin/bash
set -e

# Create the web root if it doesn't exist
mkdir -p /var/www/html

# Download Adminer as index.php
wget -O /var/www/html/index.php https://www.adminer.org/latest.php

# Set proper ownership and permissions
chown -R www-data:www-data /var/www/html
chmod 755 /var/www/html/index.php

# Remove default index.html if present
rm -f /var/www/html/index.html

# Start PHP built-in server
cd /var/www/html
php -S 0.0.0.0:80