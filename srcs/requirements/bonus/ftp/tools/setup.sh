#!/bin/sh
set -e

if [ -n "$FTP_USER" ] && [ -n "$FTP_PASSWORD" ]; then
    if ! id "$FTP_USER" >/dev/null 2>&1; then
        echo "Creating FTP user $FTP_USER"
        useradd -d /var/www/html -s /bin/bash "$FTP_USER"
        echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
        usermod -aG www-data "$FTP_USER"
    fi
fi

exec vsftpd /etc/vsftpd/vsftpd.conf