FROM debian:12

RUN apt update && apt upgrade -y

RUN apt install -y\
	wget\
	php\
	php-mysql

COPY ./tools/setup.sh /

RUN chmod +x /setup.sh

ENTRYPOINT [ "./setup.sh" ]