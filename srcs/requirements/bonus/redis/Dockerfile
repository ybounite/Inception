FROM debian:12

RUN apt update && apt upgrade -y

RUN apt install -y redis-server

# Configure Redis to listen on all interface and turn off protected mode
# This allows the WordPress container to connect to it.

RUN sed -i "s/bind 127.0.0.1 -::1/bind 0.0.0.0/" /etc/redis/redis.conf \
	&& echo "protected-mode no" >> /etc/redis/redis.conf

EXPOSE 6379

# Start Redis server in the foreground
CMD [ "redis-server", "--protected-mode", "no" ]