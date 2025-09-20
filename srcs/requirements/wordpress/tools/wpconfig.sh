#!/bin/bash

while ! mariadb -h mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" 2>/dev/null; do
    echo "Waiting for MariaDB Connection...";
    sleep 2
done

echo "MariaDB Connection Successful!"

echo "Creating WordPress Database..."
wp config create --allow-root \
	--dbname=$MYSQL_DATABASE \
	--dbuser=$MYSQL_USER \
	--dbpass=$MYSQL_PASSWORD \
	--dbhost=mariadb \
	--path='/var/www/wordpress'

echo "Installing Core..."
wp core install --allow-root \
	--url="$DOMAIN_NAME" \
	--title="$WP_TITLE" \
	--admin_user="$WP_ADMIN_NAME" \
	--admin_password="$WP_ADMIN_PASSWORD" \
	--admin_email="$WP_ADMIN_MAIL" --skip-email \
	--path='/var/www/wordpress'

echo "Creating User..."
wp user create --allow-root \
	"$WP_USER_NAME" "$WP_USER_MAIL" \
	--user_pass="$WP_USER_PASSWORD" \
	--role=author --path='/var/www/wordpress'

echo "Setting up Redis Cache..."

if grep -q "WP_REDIS_HOST" /var/www/wordpress/wp-config.php; then
    sed -i "s|define('WP_REDIS_HOST'.*|define('WP_REDIS_HOST', 'redis');|" /var/www/wordpress/wp-config.php
else
    sed -i "/^\/\* That's all, stop editing! Happy publishing. \*\//i define('WP_REDIS_HOST', 'redis');" /var/www/wordpress/wp-config.php
fi

if grep -q "WP_REDIS_PORT" /var/www/wordpress/wp-config.php; then
    sed -i "s|define('WP_REDIS_PORT'.*|define('WP_REDIS_PORT', 6379);|" /var/www/wordpress/wp-config.php
else
    sed -i "/^\/\* That's all, stop editing! Happy publishing. \*\//i define('WP_REDIS_PORT', 6379);" /var/www/wordpress/wp-config.php
fi

wp plugin install redis-cache --activate --allow-root --path='/var/www/wordpress'
wp redis enable --allow-root --path='/var/www/wordpress'

echo "WordPress Configuration Completed!"
echo "Starting PHP-FPM..."

exec php-fpm7.4 -F

