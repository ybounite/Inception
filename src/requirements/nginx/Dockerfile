FROM debian:12.13-slim

RUN apt update && apt upgrade -y && apt install -y \
	nginx

RUN	rm -f /etc/nginx/sites-available/default && \
	rm -f /etc/nginx/sites-enabled/default

#copy custom nginx.conf to the container
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;"]


# COPY YOU SSL CRETIFICATE AND KEY TO THE CONTAINER
#COPY ./path to certificate/nginx.crt /etc/ssl/certs/nginx.crt
#COPY ./path to certificate / nginx.key /etc/ssl/private/nginx.key
#inception/
#├── Makefile
#├── srcs/
#│ ├── docker-compose.yml
#│ ├── requirements/
#│ │ ├── mariadb/
#│ │ │ ├── Dockerfile
#│ │ │ └── tools/
#│ │ │ └── script.sh
#│ │ ├── nginx/
#│ │ │ ├── Dockerfile
#│ │ │ └── conf/
#│ │ │ └── nginx.conf
#│ │ ├── wordpress/
#│ │ │ ├── Dockerfile
#| | | ├── tools/
#| | | | ├── wordpress.sh