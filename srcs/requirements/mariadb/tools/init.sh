#!/bin/bash

# Initialize database if it doesn't exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "MARIADB: Initializing database..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --auth-root-authentication-method=normal
    
    # Start temporary server to set up users and database
    echo "MARIADB: Setting up initial configuration..."
    mysqld_safe --skip-networking &
    
    # Wait for server to start
    sleep 5
    
    # Create database and user from environment variables
    mysql -uroot <<EOF
        CREATE DATABASE IF NOT EXISTS \${MYSQL_DATABASE};
        CREATE USER IF NOT EXISTS '\${MYSQL_USER}'@'%' IDENTIFIED BY '\${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \${MYSQL_DATABASE}.* TO '\${MYSQL_USER}'@'%';
        FLUSH PRIVILEGES;
        ALTER USER 'root'@'localhost' IDENTIFIED BY '\${MYSQL_ROOT_PASSWORD}';
EOF
    
    # Shutdown temporary server
    mysqladmin -uroot -p\${MYSQL_ROOT_PASSWORD} shutdown
    sleep 3
fi

echo "MARIADB: Starting server..."
exec mysqld_safe
