FROM debian:12

RUN apt update && apt upgrade -y

RUN apt install -y redis-server

RUN sed -i "s/bind 127.0.0.1 -::1/bind 0.0.0.0/" /etc/redis/redis.conf \
	&& echo "protected-mode no" >> /etc/redis/redis.conf

EXPOSE 6379

# Start Redis server in the foreground
ENTRYPOINT [ "redis-server", "--protected-mode", "no" ]