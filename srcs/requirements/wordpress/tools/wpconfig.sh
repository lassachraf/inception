!/bin/bash

# Wait for MariaDB to be ready
while ! mariadb -h mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" 2>/dev/null; do
    echo "Waiting for MariaDB Connection..."
    sleep 2
done

echo "MariaDB Connection Successful!"

# Wait for Redis to be ready (ALWAYS wait for Redis)
while ! redis-cli -h redis ping 2>/dev/null | grep -q "PONG"; do
    echo "Waiting for Redis Connection..."
    sleep 2
done
echo "Redis Connection Successful!"

echo "Creating WordPress Configuration..."

wp config create --allow-root \
    --dbname="$MYSQL_DATABASE" \
    --dbuser="$MYSQL_USER" \
    --dbpass="$MYSQL_PASSWORD" \
    --dbhost="mariadb" \
    --path="/var/www/wordpress"

# ALWAYS configure Redis (remove the if condition)
echo "Configuring Redis Object Cache..."
echo "Configuring Redis in wp-config.php..."

# Define Redis configuration - MUST include WP_CACHE true
REDIS_CONFIG=$(cat << EOF
// Redis Object Cache Configuration
define('WP_CACHE', true);
define('WP_REDIS_HOST', 'redis');
define('WP_REDIS_PORT', 6379);
define('WP_REDIS_TIMEOUT', 1);
define('WP_REDIS_READ_TIMEOUT', 1);
define('WP_REDIS_DATABASE', 0);
\$redis_server = array('host' => 'redis', 'port' => 6379);
EOF
)

# Append Redis configuration to wp-config.php
echo "$REDIS_CONFIG" >> /var/www/wordpress/wp-config.php

# Install Redis Object Cache plugin
echo "Installing Redis Object Cache plugin..."
wp plugin install redis-cache --activate --allow-root --path="/var/www/wordpress"

# Enable Redis Object Cache
echo "Enabling Redis Object Cache..."
wp redis enable --allow-root --path="/var/www/wordpress"

# ... rest of your script remains the same
echo "Installing Core..."
wp core install --allow-root \
    --url="$DOMAIN_NAME" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_MAIL" --skip-email \
    --path="/var/www/wordpress"

echo "Creating User..."
wp user create --allow-root \
    "$WP_USER_NAME" "$WP_USER_MAIL" \
    --user_pass="$WP_USER_PASSWORD" \
    --role=author \
    --path="/var/www/wordpress"

# Final Redis status check
echo "Checking Redis status..."
wp redis status --allow-root --path="/var/www/wordpress"
echo "Testing Redis connection..."
wp redis test --allow-root --path="/var/www/wordpress"

echo "WordPress Configuration Completed!"
echo "Starting PHP-FPM..."

exec php-fpm7.4 -F