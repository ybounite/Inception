# wordpress install 
FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update

RUN apt install -y \
	php8.2\
	php8.2-fpm\ 
	php\
	php-mysql\
	curl

RUN apt upgrade -y

COPY ./tools/script.sh /usr/local/bin/.

WORKDIR /usr/local/bin/

RUN chmod +x ./script.sh

EXPOSE 9000

CMD ["./script.sh"]
