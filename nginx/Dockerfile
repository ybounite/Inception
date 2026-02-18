FROM debian:12

RUN apt update && apt upgrade -y

RUN apt install -y\
	nginx \
	openssl

#copy the server config from the host machine repo to the container
COPY conf/nginx.conf /etc/nginx/sites-available/default

CMD [ "nginx", "-g", "daemon off;" ]
