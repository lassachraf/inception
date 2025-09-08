#!/bin/bash

mkdir -p /run/php/
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/' /etc/php/7.4/fpm/pool.d/www.conf

if [ -z "$(ls -A /var/www/html)" ]; then
    echo "WORDPRESS: Extracting WordPress files to volume..."
    curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
    tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 && \
    rm /tmp/wordpress.tar.gz
else
    echo "WORDPRESS: Volume already contains files, skipping extraction."
fi

# Create WordPress config from environment variables
cat > /var/www/html/wp-config.php << EOF
<?php
define('DB_NAME', '${MYSQL_DATABASE}');
define('DB_USER', '${MYSQL_USER}');
define('DB_PASSWORD', '${MYSQL_PASSWORD}');
define('DB_HOST', 'mariadb');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

define('WP_HOME', 'https://${DOMAIN_NAME}');
define('WP_SITEURL', 'https://${DOMAIN_NAME}');

\$table_prefix = 'wp_';

define('WP_DEBUG', false);

if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');

require_once(ABSPATH . 'wp-settings.php');
EOF

# Set correct permissions for config
chown www-data:www-data /var/www/html/wp-config.php
chmod 644 /var/www/html/wp-config.php

echo "WORDPRESS: Starting PHP-FPM..."
exec php-fpm7.4 -F -R
