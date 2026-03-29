FROM debian:12

RUN apt update && apt upgrade -y

RUN apt install -y \
    nginx \
    openssl 

RUN mkdir -p /etc/nginx/ssl 

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj "/CN=localhost" \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt

COPY conf/nginx.conf /etc/nginx/conf.d/nginx.conf
COPY tools/index.html /var/www/html/index.html

EXPOSE 8081

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]