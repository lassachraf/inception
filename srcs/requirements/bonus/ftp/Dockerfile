FROM        debian:bullseye

RUN         apt-get update && \
            apt-get install -y vsftpd && \
            apt-get clean && \
            rm -rf /var/lib/apt/lists/*


COPY        conf/vsftpd.conf /etc/vsftpd.conf
COPY        tools/start_ftp.sh /

RUN         chmod +x /start_ftp.sh

EXPOSE      20 21

CMD         ["./start_ftp.sh"]
