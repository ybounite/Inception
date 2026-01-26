IMAGE-NAME = image-nginx
CONTAINER-NAME = container-nginx
PORT = 8080
.PHONY: all build run stop clean help

all: build

build:
	sudo docker build -t $(IMAGE-NAME) .

run:
	sudo docker run -d --name $(CONTAINER-NAME) -p $(PORT)

stop:
	sudo docker stop $(CONTAINER-NAME)
	sudo docker rm $(CONTAINER-NAME)

clean: stop
	sudo docker rmi -f $(IMAGE-NAME)

help:
	@echo "Available targets:"
	@echo "  make build      - Build Docker image"
	@echo "  make run        - Build and run container"
	@echo "  make stop       - Stop and remove container"
#	@echo "  make restart    - Stop and restart container"
	@echo "  make clean      - Remove image and container"
#	@echo "  make logs       - View container logs"