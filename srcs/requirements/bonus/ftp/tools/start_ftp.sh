#!/bin/bash

# Create FTP user
useradd -m -d /var/www/wordpress -s /bin/bash $FTP_USER
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

# Set permissions
chown -R $FTP_USER:$FTP_USER /var/www/wordpress
chmod -R 755 /var/www/wordpress

# Create vsftpd user list
echo $FTP_USER > /etc/vsftpd.userlist

# Start vsftpd
exec vsftpd /etc/vsftpd.conf
