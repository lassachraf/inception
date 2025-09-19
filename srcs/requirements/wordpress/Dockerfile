FROM	debian:bullseye

RUN		apt update -y && apt install -y wget php php-fpm php-mysql mariadb-client && \
        apt-get clean && rm -rf /var/lib/apt/lists/*

RUN		wget https://wordpress.org/wordpress-6.8.1.tar.gz -P /var/www

RUN 	cd /var/www && tar -xzf wordpress-6.8.1.tar.gz && rm wordpress-6.8.1.tar.gz

RUN		chmod -R 777 /var/www/wordpress

COPY 	conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN		chmod 777 wp-cli.phar

RUN		mv wp-cli.phar /usr/local/bin/wp

COPY 	tools/wpconfig.sh /

RUN     mkdir /run/php

CMD		["bash", "wpconfig.sh"]
