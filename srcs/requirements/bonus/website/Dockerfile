FROM	    debian:bullseye

RUN		    apt update -y && \
		    apt install  -y nginx

COPY	    conf/nginx.conf /etc/nginx/nginx.conf
COPY	    tools/* /var/www/html/

EXPOSE	    80

CMD		    ["nginx", "-g", "daemon off;"]

