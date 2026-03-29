FROM debian:12

RUN apt update && apt upgrade -y && \
    apt install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -newkey rsa:4096 -days 365 \
        -out /etc/nginx/ssl/server.crt -keyout /etc/nginx/ssl/server.key \
        -subj "/CN=ybounite.42.fr/UID=ybounite"

COPY conf/nginx.conf /etc/nginx/sites-available/default

EXPOSE 443

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
