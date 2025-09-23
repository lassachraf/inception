#!/bin/bash

# Create FTP user
useradd -m -d /var/www/wordpress -s /bin/bash $FTP_USER
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

chmod 777 /var/www/wordpress/

# Start vsftpd
exec vsftpd /etc/vsftpd.conf
