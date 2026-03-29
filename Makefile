DOCKER = docker-compose -f srcs/docker-compose.yml

LOCAL_DIR = /home/ybounite/data/

all: up

up:
	@mkdir -p $(LOCAL_DIR)wp
	@mkdir -p $(LOCAL_DIR)db
	@mkdir -p $(LOCAL_DIR)portainer
	$(DOCKER) up -d --build

down:
	$(DOCKER) down

build:
	$(DOCKER) build

stop:
	$(DOCKER) stop

restart:
	$(DOCKER) restart

ps:
	$(DOCKER) ps

logs:
	$(DOCKER) logs
vls:
	docker volume ls

clean: stop
	$(DOCKER) down --volumes

fclean: clean
	docker system prune -fa
	docker volume prune
	$(DOCKER) down --rmi all
	@sudo rm -rf $(LOCAL_DIR)

re: clean all

.PHONY: up down build stop restart ps logs clean re 