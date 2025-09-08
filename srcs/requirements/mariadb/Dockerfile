FROM		debian:bullseye

RUN		apt update -y && \
		apt install mariadb-server -y && \
		mkdir -p /etc/mysql/conf.d

EXPOSE		3306

COPY		tools/init_mariadb.sh /usr/local/bin/
COPY		conf/99-custom.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN		chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf
RUN		chmod 755 /usr/local/bin/init_mariadb.sh

CMD ["/usr/local/bin/init_mariadb.sh"]

