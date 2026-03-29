# DEV_DOC.md — Developer Documentation

---

## Environment Setup From Scratch

This project runs entirely within Docker containers with minimal local dependencies.

### Prerequisites

Required tools must be installed on a Linux-based system:

- **Docker**
- **Docker Compose**
- **Make**
- **Git**

### Repository Setup

1. Clone the project repository:
   ```bash
   git clone <repository-url>
   cd Inception
   ```

2. Verify the directory structure includes:
   - `srcs/docker-compose.yml`
   - `srcs/requirements/` with service Dockerfiles
   - `Makefile`

---

## Configuration and Secrets

### Environment File (.env)

- Located at: `srcs/.env`
- Contains all configuration and secrets:
  - Database credentials (root password, user, password)
  - Database name
  - FTP credentials
  - Service-specific environment variables

**Example `.env` structure:**
```env
DB_ROOT_PASSWORD=secure_root_pass
DB_NAME=wordpress
DB_USER=wordpress
DB_PASSWORD=secure_db_pass
FTP_USER=ftpuser
FTP_PASSWORD=secure_ftp_pass
```
---

## Building and Launching the Project

### Using Makefile

```bash
make up          # Build and start all services
make down        # Stop services (preserve data)
make stop        # Stop without removing containers
make restart     # Restart all services
make build       # Rebuild images only
make clean       # Stop and remove containers
make fclean      # Complete cleanup (removes everything)
make re          # Full restart from scratch
make ps          # Show running containers
make logs        # View service logs
```

### Manual Docker Compose

```bash
docker-compose -f srcs/docker-compose.yml up -d --build
docker-compose -f srcs/docker-compose.yml down
docker-compose -f srcs/docker-compose.yml logs -f
```

**Build Order:** MariaDB → WordPress → NGINX (automatic dependency resolution)

---

## Managing Containers and Volumes

### Container Management

Each service runs in its own named container:
- `nginx` — Web server (HTTPS)
- `wordpress` — Application layer
- `mariadb` — Database server
- `redis` — Cache (bonus)
- `ftp` — FTP server (bonus)
- `adminer` — Database UI (bonus)
- `portainer` — Container management (bonus)
- `portfelio` — Portfolio site (bonus)

### Individual Container Operations

```bash
docker-compose -f srcs/docker-compose.yml start <service>
docker-compose -f srcs/docker-compose.yml stop <service>
docker-compose -f srcs/docker-compose.yml logs -f <service>
docker-compose -f srcs/docker-compose.yml exec <service> /bin/sh
```

### Volume Management

Named volumes persist data across container restarts:

```bash
docker volume ls                    # List all volumes
docker volume inspect <volume>      # View volume details
docker volume rm <volume>           # Remove volume (deletes data)
```

---

## Data Storage and Persistence

### Persistent Storage Locations

Data is stored in named Docker volumes mounted on the host:

**Database Volume:**
- Path: `/home/ybounite/data/db/`
- Mount point: `/var/lib/mysql` (inside MariaDB container)
- Persists: Database tables, user data, WordPress configuration

**WordPress Volume:**
- Path: `/home/ybounite/data/wp/`
- Mount point: `/var/www/html` (inside WordPress & NGINX)
- Persists: Website files, uploads, themes, plugins

**Portainer Volume:**
- Path: `/home/ybounite/data/portainer/`
- Persists: Portainer configuration and data

### Data Persistence Guarantees

- Data survives container stops/restarts
- Data persists during image rebuilds
- Data requires explicit removal via `make fclean` or `docker volume rm`
- Volumes created automatically on first `make up`

---

## Project Architecture Notes

- Services communicate via dedicated Docker bridge network: `net-incption`
- All application images built locally; no external images pulled
- Custom Dockerfiles use Alpine Linux or Debian distributions
- TLS/SSL encryption on NGINX with port 443 only for external access
- Internal communication happens on private network (no exposed ports between services)
- Any `.env` changes require project restart to take effect

---

**For end-user instructions, see [USER_DOC.md](USER_DOC.md)**
