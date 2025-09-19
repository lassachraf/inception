FROM	debian:bullseye

RUN		apt update -y && \
		apt install  -y nginx openssl && \
		mkdir -p /etc/nginx/ssl

RUN 	openssl req -x509 -nodes \
		-keyout /etc/nginx/ssl/inception.key \
		-out /etc/nginx/ssl/inception.crt \
		-subj "/C=MA/ST=BG/L=1337/O=42/OU=42/CN=alassiqu.42.fr/UID=alassiqu"

COPY	conf/nginx.conf /etc/nginx/nginx.conf

CMD		["nginx", "-g", "daemon off;"]
