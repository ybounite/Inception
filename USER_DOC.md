# User Documentation - Inception Project

Welcome! This document explains how to use the Inception project, a Docker-based web infrastructure stack. Whether you're an end user or an administrator, this guide will help you navigate the system.

---

## 📦 Understanding the Services

The Inception stack provides a complete web infrastructure with the following services:

### Core Services

- **NGINX** (Port 443)
  - Web server with TLS/SSL encryption
  - Serves the WordPress website securely
  - Your entry point to access the website

- **WordPress** (Behind NGINX)
  - Content management system (CMS)
  - Where you manage your website content
  - Accessible through NGINX on port 443

- **MariaDB** (Internal)
  - Database server
  - Stores all WordPress data (posts, users, settings, etc.)
  - Not directly accessible from outside the container network

### Bonus Services

- **Adminer** (Port 600)
  - Database management tool
  - GUI for managing MariaDB databases
  - Useful for administrators and developers

- **FTP** (Port 21)
  - File transfer protocol server
  - Upload/download files to the website
  - Uses passive mode ports 10000-10100

- **Redis** (Internal)
  - In-memory cache service
  - Improves performance (used internally)

- **Portfolio** (Port 8081)
  - Additional portfolio website
  - Independent web application

- **Portainer** (Port 9443)
  - Docker container management interface
  - Monitor and manage all containers
  - Advanced administration tool

---

## 🚀 Starting and Stopping the Project

### Start the Project

To start all services:

```bash
make up
```

Or manually with Docker Compose:

```bash
docker-compose -f srcs/docker-compose.yml up -d
```

**What happens:**
- All containers are built (if needed) and started
- Data directories are automatically created
- Services establish network connections
- Initial configuration runs automatically

**Startup time:** 30-60 seconds for full initialization

### Stop the Project

To stop all services:

```bash
make stop
```

Or manually:

```bash
docker-compose -f srcs/docker-compose.yml stop
```

**Note:** Stopping preserves all data and configurations. Services can be restarted later.

### Restart the Project

To restart all services:

```bash
make restart
```

This stops and then starts all containers without removing data.

### Complete Shutdown (Clean)

To stop and remove all containers:

```bash
make down
```

**Warning:** This removes containers but preserves volumes (data).

### Full Cleanup (Dangerous)

To remove everything including volumes and images:

```bash
make fclean
```

**Warning:** This deletes all project data. Use only when you want a complete fresh start.

---

## 🌐 Accessing Services and Administration Panels

### Main Website

**URL:** `https://ybounite`

- Your main WordPress website
- Navigate to manage content through the WordPress dashboard
- Administrative access: `/wp-admin`

### WordPress Dashboard

**URL:** `https://ybounite/wp-admin`

- Login with your WordPress credentials
- Manage posts, pages, plugins, themes, and users
- Configure website settings

### Adminer (Database Tool)

**URL:** `http://ybounite/adminer`

- Server: `mariadb` (internal hostname)
- Username: See [Credentials Section](#-locating-and-managing-credentials)
- Database: `wordpress`

**Features:**
- View database structure
- Execute SQL queries
- Backup/restore data
- Manage tables and records

### Portainer (Docker Management)

**URL:** `https://ybounite/portainer`

**First-time setup:**
- Create an admin user
- Connect to the local Docker socket
- Manage all containers and images

**Features:**
- Monitor container health and resource usage
- View logs in real-time
- Start/stop containers
- Manage networks and volumes

### Portfolio

**URL:** `http://ybounite:8081`

- Additional portfolio website
- Independent from WordPress

### FTP Access

**Host:** `ybounite`
**Port:** `21`
**Passive Ports:** `10000-10100`

Use any FTP client (like FileZilla):

1. Connect to `ybounite` on port 21
2. Use credentials from environment variables
3. Upload/download files to website directory

---

## 🔐 Locating and Managing Credentials

### Environment Variables File

Credentials are stored in: `srcs/.env`

**Location:** `/path/to/project/srcs/.env`

**Important:** Never commit this file to version control. It contains sensitive information.

### Default Credentials Structure

The `.env` file contains:

```env
# Database credentials
DB_ROOT_PASSWORD=root_password
DB_NAME=wordpress
DB_USER=wordpress
DB_PASSWORD=wordpress_password

# FTP credentials (if applicable)
FTP_USER=ftp_user
FTP_PASSWORD=ftp_password
```

### Accessing and Modifying Credentials

**To view credentials:**

```bash
cat srcs/.env
```

**To change credentials:**

1. Edit the `.env` file:
   ```bash
   nano srcs/.env
   # or use your preferred editor
   ```

2. Restart the project:
   ```bash
   make down
   make up
   ```

**Important Notes:**
- Changes to `.env` require a project restart
- Some credentials are embedded during container build
- For WordPress, some credentials are set during first-time setup

### WordPress Admin Credentials

Created during WordPress initialization. Set these when first accessing:

**URL:** `https://ybounite/wp-admin`

- Username: Set during first access
- Password: Set during first access

**Recovery:**
If you forget WordPress credentials, use Adminer to reset them:

1. Access Adminer: `http://ybounite/adminer`
2. Navigate to the `wp_users` table
3. Update user credentials as needed

---

## ✅ Checking That Services Are Running Correctly

### Quick Health Check

Check all running containers:

```bash
make ps
```

Or manually:

```bash
docker-compose -f srcs/docker-compose.yml ps
```

**Expected output:** All services showing `Up` status

### Service Status Details

**Should see running:**
- `nginx` — Web server
- `wordpress` — WordPress application
- `mariadb` — Database
- `redis` — Cache (bonus)
- `ftp` — FTP server (bonus)
- `portainer` — Container management (bonus)
- `adminer` — Database tool (bonus)
- `portfelio` — Portfolio site (bonus)

### View Service Logs

Check logs for specific service:

```bash
make logs
```

Or for a specific service:

```bash
docker-compose -f srcs/docker-compose.yml logs wordpress
docker-compose -f srcs/docker-compose.yml logs mariadb
docker-compose -f srcs/docker-compose.yml logs nginx
```

**Look for:**
- No error messages
- Successful service initialization
- Connection confirmations between services

### Test Each Service

**NGINX/WordPress:**
```bash
curl -k https://ybounite
```
(Should return HTML of your website)

**Database Connection:**
- Access Adminer: `http://ybounite/adminer` or 
- If you can log in, database is running

**Portainer:**
- Visit `https://ybounite/portainer`
- If it loads, Docker management is working

**FTP:**
```bash
ftp ybounite
# Should prompt for credentials
```

### Common Issues and Fixes

| Issue | Solution |
|-------|----------|
| Port already in use | Stop other services or change ports in docker-compose.yml |
| Services won't start | Check logs with `make logs` |
| Database connection fails | Verify `.env` credentials in MariaDB container |
| Website shows blank page | Check WordPress logs and database connection |
| Slow startup | Wait 30-60 seconds during initial build |
| Permission denied errors | Ensure Docker daemon is running and user has Docker permissions |

---

## 📋 Reference: Common Commands

| Command | Purpose |
|---------|---------|
| `make up` | Start all services |
| `make down` | Stop services (keep data) |
| `make stop` | Stop without removing containers |
| `make restart` | Restart all services |
| `make ps` | Show running containers |
| `make logs` | View service logs |
| `make clean` | Stop and remove containers (keep volumes) |
| `make fclean` | Complete cleanup (removes everything) |
| `make re` | Full restart from scratch |

---

## Support and Troubleshooting

### Getting Help

1. **Check logs first:** `make logs`
2. **Verify all containers running:** `make ps`
3. **Test internet connectivity:** Essential for initial setup
4. **Review `.env` configuration:** Ensure all required variables are set

### Data Persistence

Your data is stored in Docker volumes at:

```
/home/ybounite/data/
├── wp/       # WordPress files
├── db/       # MariaDB databases
└── portainer/# Portainer data
```

Volumes persist even if containers are stopped or removed (until `make fclean`).

---

For technical developer documentation, see [DEV_DOC.md](DEV_DOC.md).
