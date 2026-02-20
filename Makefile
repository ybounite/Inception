DOCKER = docker-compose -f srcs/docker-compose.yml

LOCAL_DIR = /home/ybounite/data/

all: up

up:
	@mkdir -p $(LOCAL_DIR)wp
	@mkdir -p $(LOCAL_DIR)db
	$(DOCKER) up -d --build

down:
	$(DOCKER) down -v
	@sudo rm -rf $(LOCAL_DIR)wp/*
	@sudo rm -rf $(LOCAL_DIR)db/*

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

clean: stop
	$(DOCKER) down --rmi -a --volumes -f
	@sudo rm -rf $(LOCAL_DIR)

re: clean all

.PHONY: up down build stop restart ps logs clean re 