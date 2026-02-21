*This project has been created as part of the 42 curriculum by ybounite.*

## Description

**Inception** is a system administration and DevOps project focused on building a secure and modular web infrastructure using Docker.

The goal of the project is to design and deploy a multi-container architecture composed of:

- **NGINX** (Web server with TLSv1.2 / TLSv1.3)
- **WordPress + php-fpm** (Application layer)
- **MariaDB** (Database server)

Each service runs in its own isolated Docker container, built from custom Dockerfiles using Alpine Linux or the penultimate stable version of Debian.

The project demonstrates:

- Containerization principles
- Service isolation
- Secure inter-container communication
- Data persistence using Docker volumes
- Infrastructure orchestration with Docker Compose
- Secure configuration using environment variables

This project simulates a production-like infrastructure while respecting strict architectural and security constraints.

## Instructions

### Prerequisites

- Docker Engine (20.10+)
- Docker Compose (v2+)
- Make

### Installation & Execution

1. Clone the repository:

```bash
git clone git@github.com:ybounite/Inception.git
cd Inception
```
----
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
---

## Use of Docker & Design Choices

Docker is used to package each service into lightweight, isolated containers.  
Docker Compose orchestrates these services, manages networking, and handles persistent storage.

### Virtual Machines vs Docker

|   Virtual Machines   |        Docker      |
├──────────────────────┼────────────────────┤
| Full guest OS        | Shares host kernel |
| Heavy resource usage | Lightweight        |
| Slow startup         | Fast startup       |
| Large disk footprint | Small footprint    |

**Design choice:** Docker is more efficient, portable, and suitable for microservice architectures.

---

### Secrets vs Environment Variables

|          Secrets           |     Environment Variables      |
├────────────────────────────┼────────────────────────────────┤
| Secure storage             | Plain-text exposure            |
| Recommended for sensitive data | Suitable for configuration |
| Managed securely            | Visible in container          |

**Design choice:**  
Environment variables are used as required by the subject. In real production environments, Docker Secrets would be preferred for sensitive credentials.

---

### Docker Network vs Host Network

|    Docker Bridge Network   |    Host Network              |
├────────────────────────────┼──────────────────────────────┤
| Isolated internal network  |  Shares host network         |
| Service name resolution    |  Direct port exposure        |
| More secure                |  Less isolation              |

**Design choice:**  
A custom Docker bridge network ensures secure internal communication between services.

---

### Docker Volumes vs Bind Mounts

|      Docker Volumes        |      Bind Mounts             |
├────────────────────────────┼──────────────────────────────┤
| Managed by Docker          | Linked directly to host path │
| Portable                   | Host-dependent               │
| Recommended for production | Often used in development    │

**Design choice:**  
Docker volumes are used to persist WordPress and MariaDB data.

---

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

## Resources

Classic references used for this project:

- Docker documentation: https://docs.docker.com/
- Docker Compose documentation: https://docs.docker.com/compose/
- Docker Deep Dive: Zero to Docker in a Single Book 
![Docker_DeepDiveZeroToDockerInASingleBook.pdf](Inception_42/Docker_Book.pdf)
- NGINX documentation: https://nginx.org/en/docs/
- WordPress documentation: https://wordpress.org/documentation/
- PHP-FPM documentation: https://www.php.net/manual/en/install.fpm.php
- MariaDB documentation: https://mariadb.com/kb/en/documentation/
- OWASP TLS/HTTPS best practices: 

### AI Usage Disclosure

AI assistance was used for:

- README proofreading and structure improvements
- wording and grammar refinement
- validating section completeness against subject requirements

AI was **not** used to replace core project implementation decisions or mandatory manual setup/testing steps.