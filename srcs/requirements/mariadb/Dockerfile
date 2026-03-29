FROM debian:12

RUN apt update -y && apt upgrade -y

RUN apt install mariadb-server -y

COPY ./tools/script.sh /usr/local/bin

WORKDIR /usr/local/bin/

RUN chmod +x ./script.sh

EXPOSE 3306

ENTRYPOINT [ "./script.sh" ]