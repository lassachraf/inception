FROM		debian:bullseye

RUN		apt update -y && \
		apt install  -y nginx openssl && \
		mkdir -p /etc/nginx/ssl

RUN 		openssl req -x509 -nodes -days 365 \
		-keyout /etc/nginx/ssl/inception.key \
		-out /etc/nginx/ssl/inception.crt \
		-subj "/C=MA/ST=BG/O=1337/CN=alassiqu.42.fr"

RUN		rm -f /etc/nginx/sites-enabled/default && \
		chown -R www-data:www-data /var/www/html && \
		chmod -R 755 /var/www/html

COPY		conf/default.conf /etc/nginx/nginx.conf

CMD		["nginx", "-g", "daemon off;"]
