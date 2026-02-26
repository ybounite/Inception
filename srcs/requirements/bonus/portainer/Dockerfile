FROM debian:12

RUN apt update && apt upgrade -y

RUN apt update && apt install -y wget \
    && wget https://github.com/portainer/portainer/releases/download/2.27.0/portainer-2.27.0-linux-amd64.tar.gz && \
    tar -xzf portainer-2.27.0-linux-amd64.tar.gz -C /usr/local/bin/ --strip-components=1 && \
    rm portainer-2.27.0-linux-amd64.tar.gz

RUN mkdir -p /data

# Expose the ports: 9443 for the Web UI (HTTPS) and 8000 for the Edge tunnel (optional)
EXPOSE 9443 8000

CMD ["/usr/local/bin/portainer", "-H", "unix:///var/run/docker.sock", "--data", "/data"]