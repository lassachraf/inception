FROM		debian:bullseye

RUN		apt update -y && \
		apt install -y php-fpm php-mysql curl && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/*

RUN		mkdir -p /var/www/html

RUN		curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
		tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 && \
		rm /tmp/wordpress.tar.gz

RUN		chown -R www-data:www-data /var/www/html && \
		chmod -R 755 /var/www/html

COPY		tools/wordpress-configuration.sh /usr/local/bin/
RUN		chmod +x /usr/local/bin/wordpress-configuration.sh

EXPOSE		9000

CMD		["/usr/local/bin/wordpress-configuration.sh"]
