#Get base image from docker hub
FROM debian:bullseye

#listen to port 3306 at runtime. Port 3306 ist default port for maria db to listen to DB server
EXPOSE 3306

# Update and upgrade:
RUN apt update -y && apt upgrade -y

# Install MariaDB:
RUN apt install mariadb-server -y

# Copy config file from the host machine for mariadb to the /etc of the container
COPY ./conf/mariadb.cnf /etc/mysql/mariadb.cnf

# Copy setup script from the host machine to the container:
COPY ./tools/script.sh /usr/local/bin

WORKDIR /usr/local/bin/

RUN chmod +x ./script.sh

CMD [ "./script.sh" ]