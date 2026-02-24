FROM debian:12

RUN apt update && apt upgrade -y

RUN apt install -y \
	vsftpd

COPY conf/setup.sh /

CMD [ "./setup.sh" ]