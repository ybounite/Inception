*This project has been created as part of the 42 curriculum by ybounite.*

# Description
The Inception project consists of setting up a small infrastructure composed of multiple services using Docker and Docker Compose, all hosted within a virtual machine. The goal is to build each service from scratch with custom Dockerfiles and orchestrate them with Docker Compose while following best practices for containerization.

## 📋 Project Overview

This probect create a small infrastruction usinf Docker container with the following server:

- ***NGINX*** Web server with TLSv1.2 or TLSv1.3
- ***WordPress + php-fpm*** Content management system (without nginx)
- ***MariaDB***  Database server (without nginx)

Each service runs in a dedicated Docker container built from custom Dockerfiles (Alpine Linux or Debian penultimate stable version).

## Key Features

- Custom Docker images (no pre-built images from DockerHub except Alpine/Debian base)
- Secure HTTPS connection with TLS
- Docker volumes for persistent data storage
- Isolated Docker network for service communication
- Environment variables for configuration
- Automatic container restart on crash
- Makefile for easy management

## 🚀 Quick Start

### Prerequisites

- Docker Engine (20.10+)
- Docker Compose (2.0+)
- Make


### Installation

1. Clone the repository:
```bash
git clone git@github.com:ybounite/Inception.git
cd Inception
```

2. Configure environment variables:
```bash
cp ../.env srcs/requirements/
# Edit .env with your credentials
```

3. Start the infrastructure:
```bash
make
```

4. Access the website:
```
https://ybounite.42.fr
```

## 📚 Documentation

- **[User Documentation](USER_DOC.md)** - For end users and administrators
  - How to start/stop services
  - Access URLs and credentials
  - Troubleshooting guide
  
- **[Developer Documentation](DEV_DOC.md)** - For developers
  - Environment setup from scratch
  - Build and deployment process
  - Container and volume management
  - Network architecture

## 🛠️ Available Commands

```bash
make          # Build and start all services
make up       # Start all services
make down     # Stop all services
make build    # Build all images
make ps       # Show running containers
make logs     # View container logs
make restart  # Restart all services
make clean    # Stop and remove containers
make fclean   # Complete cleanup (removes volumes)
make re       # Rebuild everything from scratch
```

## 📁 Project Structure

```
.
├── Makefile                         # Build automation
├── srcs/
|   ├──docker-compose.yml            # Container orchestration
|   ├── .env                         # Environment variables
│   └── requirements/
│       ├── nginx/
│       │   ├── Dockerfile           # NGINX container
│       │   ├── conf/                # NGINX configuration
│       │   └── tools/               # Setup scripts
│       ├── wordpress/
│       │   ├── Dockerfile           # WordPress + php-fpm
│       │   ├── conf/                # PHP configuration
│       │   └── tools/               # WordPress setup scripts
│       └── mariadb/
│           ├── Dockerfile           # MariaDB container
│           ├── conf/                # Database configuration
│           └── tools/               # Database setup scripts
├── README.md                        # This file
├── USER_DOC.md                      # User documentation
└── DEV_DOC.md                       # Developer documentation
```

## 📦 Docker Volumes

Persistent data is stored in Docker volumes:

- `wp` - WordPress files and uploads
- `md` - Database files
`

## 🏗️ Architecture

```
    ┌────────────────────────────────────────┐
    │           Docker Network               │
    │                                        │
    │  ┌─────────┐    ┌──────────┐           │
    │  │  NGINX  │───▶│WordPress │           │
    │  │  :443   │    │ php-fpm  │           │
    │  └─────────┘    └────┬─────┘           │
    │                      │                 │
    │                      ▼                 │
    │                 ┌─────────┐            │
    │                 │ MariaDB │            │
    │                 │  :3306  │            │
    │                 └─────────┘            │
    │                                        │
    └────────────────────────────────────────┘
            │                    │
            ▼                    ▼
      wordpress_data        mariadb_data
        (volume)             (volume)
```

## ✅ Project Requirements

- [x] Docker Compose for multi-container setup
- [x] Custom Dockerfiles for each service
- [x] Alpine Linux or Debian penultimate stable
- [x] No pre-built Docker images (except base OS)
- [x] TLS 1.2/1.3 encryption
- [x] Two users in WordPress database
- [x] Domain name pointing to local IP
- [x] Environment variables for secrets
- [x] Docker volumes for persistence
- [x] Automatic container restart
- [x] Docker network for inter-service communication
- [x] Makefile for build automation


## 👥 Authors

[youssef bounite]

## 🙏 Acknowledgments

- 42 School Inception Project
- Docker Documentation
- WordPress Documentation
- NGINX Documentation
- bonus
---

## Hostname Setup

Replace `https://ybounite.42.fr` with your own hostname:

**Need help?** Check the [User Documentation](USER_DOC.md) or [Developer Documentation](DEV_DOC.md)