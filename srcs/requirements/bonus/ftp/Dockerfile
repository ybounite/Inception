FROM debian:12

RUN apt update && apt upgrade -y

RUN apt install -y \
	vsftpd

RUN mkdir -p /etc/vsftpd /var/run/vsftpd/empty

COPY tools/setup.sh /
COPY tools/vsftpd.conf /etc/vsftpd/vsftpd.conf

RUN chmod +x /setup.sh

# Expose FTP control port and passive ports
EXPOSE 21 10000-10100

ENTRYPOINT [ "/setup.sh" ]