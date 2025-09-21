#!/bin/bash

# Create FTP user
useradd -d /var/www/wordpress -s /bin/bash $FTP_USER
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

# Start vsftpd
exec vsftpd /etc/vsftpd.conf
