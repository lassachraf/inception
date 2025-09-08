#!/bin/bash

# Initialize database if it doesn't exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "MARIADB: Initializing database..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --auth-root-authentication-method=normal
    
    echo "MARIADB: Starting temporary server for setup..."
    mysqld_safe --skip-networking &
    
    # Wait for server to be ready (better method)
    echo "MARIADB: Waiting for server to be ready..."
    for i in {1..30}; do
        if mysql -uroot -e "SELECT 1;" >/dev/null 2>&1; then
            break
        fi
        sleep 1
    done
    
    # Create database and user from environment variables
    echo "MARIADB: Creating database and user..."
    mysql -uroot <<EOF
CREATE DATABASE IF NOT EXISTS \${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '\${MYSQL_USER}'@'%' IDENTIFIED BY '\${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \${MYSQL_DATABASE}.* TO '\${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '\${MYSQL_ROOT_PASSWORD}';
EOF
    
    # Shutdown temporary server
    echo "MARIADB: Shutting down temporary server..."
    mysqladmin -uroot -p\${MYSQL_ROOT_PASSWORD} shutdown
    sleep 3
fi

echo "MARIADB: Starting server..."
exec mysqld_safe
