FROM debian:12

RUN apt update && apt upgrade -y

RUN apt update && apt install -y wget \
    && wget https://github.com/google/cadvisor/releases/download/v0.37.0/cadvisor \
    && chmod +x cadvisor \
    && mv cadvisor /usr/local/bin/

CMD [ "/usr/local/bin/cadvisor" ]