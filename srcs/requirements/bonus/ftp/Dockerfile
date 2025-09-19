FROM        debian:bullseye

RUN         apt-get update && \
            apt-get install -y vsftpd && \
            apt-get clean && \
            rm -rf /var/lib/apt/lists/*

RUN	    mkdir -p /var/run/vsftpd/empty && \
	    chmod 755 /var/run/vsftpd/empty

COPY        conf/vsftpd.conf /etc/vsftpd.conf
COPY        tools/start_ftp.sh /

RUN         chmod +x /start_ftp.sh

EXPOSE      20 21

CMD         ["./start_ftp.sh"]
