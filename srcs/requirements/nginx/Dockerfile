FROM debian:12

RUN apt update && apt upgrade -y && \
    apt install -y nginx openssl


# create a directory to stor SSL certificate and privet key
RUN mkdir -p /etc/nginx/ssl

# Generate a private key and SSL certificate using OpenSSL

# Generate SSL certificate and private key
RUN openssl req -x509 -nodes -newkey rsa:4096 -days 365 \
        -out /etc/nginx/ssl/server.crt -keyout /etc/nginx/ssl/server.key \
        -subj "/CN=ybounite.42.fr/UID=ybounite"

#copy the server config from the host machine repo to the container
COPY conf/nginx.conf /etc/nginx/sites-available/default

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]
