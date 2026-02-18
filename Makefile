DOCKER = docker-compose 

LOCAL_DIR = ~/data/

all: up

up:
	@mkdir -p $(LOCAL_DIR)wp
	@mkdir -p $(LOCAL_DIR)db
	$(DOCKER) up -d --build

down:
	$(DOCKER) down -v
	@sudo rm -rf $(LOCAL_DIR)wp/*
	@sudo rm -rf $(LOCAL_DIR)db/*

stop:
	$(DOCKER) stop

start:
	$(DOCKER) start

clean:
	$(DOCKER) down --rmi all --volumes
	@sudo rm -rf $(LOCAL_DIR)wp/*
	@sudo rm -rf $(LOCAL_DIR)db/*

re: clean all

.PHONY: up down start stop clean re