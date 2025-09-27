# 🎬 Inception – 42 School Project  

<p align="center">
  <img src="assets/Image.png" width="100%" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Docker-✔-blue?logo=docker"/>
  <img src="https://img.shields.io/badge/Nginx-✔-green?logo=nginx"/>
  <img src="https://img.shields.io/badge/MariaDB-✔-orange?logo=mariadb"/>
  <img src="https://img.shields.io/badge/WordPress-✔-blue?logo=wordpress"/>
  <img src="https://img.shields.io/badge/Redis-✔-red?logo=redis"/>
  <img src="https://img.shields.io/badge/FTP-✔-lightgrey?logo=files"/>
  <img src="https://img.shields.io/badge/Makefile-✔-yellow"/>
</p>

<br>

## 📖 Overview

**Inception** is a **DevOps / System Administration** project at **42 School**.  
The challenge: build a **secure, containerized infrastructure** entirely from **scratch** using **Docker Compose**.  

Instead of pulling pre-made images, everything is built via **custom Dockerfiles**.  

> 🐳 This project is your first real step into **containerization, orchestration, and service networking**.  

<br>

## 📚 Table of Contents  

- 🎯 [Goal](#goal)  
- 🛠️ [Technologies](#technologies)  
- 📂 [Structure](#structure)  
- 📊 [Architecture](#architecture)  
- 📸 [Screenshots](#screenshots)  
- 🎥 [Demo](#demo)  
- 🏆 [Grade](#grade)  
- 👨‍💻 [Author](#author)  
- ⭐ [Support](#support)  

<br>

## 🎯 <a id="goal">Goal</a>

Deploy a **mini self-hosted server infrastructure**:  

### ✅  **Nginx** (HTTPS, TLSv1.2+).  
### ✅ **WordPress** with **php-fpm**.  
### ✅ **MariaDB** database.  
### ✅ **Redis** cache.  
### ✅ **FTP server**.  
### ✅ **Adminer** (DB manager).  
### ✅ **Portainer** (Docker GUI).  
### ✅ **Static Website** (bonus).  
### ✅ **Persistent volumes** for DB & WordPress.  

<br>

## 🛠️ <a id="technologies">Technologies</a>

### - 📦 **Docker / Docker Compose** – containerization & orchestration  
### - 🌐 **Nginx** – reverse proxy, HTTPS with self-signed certificate  
### - 🗄️ **MariaDB** – relational database  
### - 📜 **WordPress** – CMS for content  
### - ⚡ **Redis** – caching  
### - 📂 **FTP** – file transfer service  
### - 🛡️ **Adminer** – DB management interface  
### - 🖥️ **Portainer** – Docker container GUI  
### - 📝 **Makefile** – automation (`make`, `make fclean`)  

<br>

## 📂 Structure  

```bash
Inception/
    ├── assets/
    ├── Makefile
    └── srcs/
        ├── docker-compose.yml
        ├── requirements/
        │   ├── mariadb/
        │   ├── nginx/
        │   ├── wordpress/
        │   └── bonus/
        │       ├── ftp/
        │       ├── redis/
        │       ├── adminer/
        │       ├── static-website/
        │       └── portainer/
        └── .env

```

<br>

## 📊 <a id="architecture">Architecture</a>

```mermaid
graph TD
    A[👤 User] -->|HTTPS| B[🌐 Nginx]
    B -->|Web traffic| C[📜 WordPress]
    C -->|DB queries| D[(🗄️ MariaDB)]
    C -->|Cache| E[(⚡ Redis)]
    B -->|Web traffic| F[🌍 Static Website]
    A -->|FTP| G[📂 FTP Server]
    H[🛡️ Adminer] -->|DB queries| D
    I[🖥️ Portainer] -->|Manage Docker| J[🐳 Docker Daemon]
    
    classDef bluePath stroke:#1f77b4,stroke-width:2px;
    classDef redPath stroke:#ff0000,stroke-width:2px;
    classDef greenPath stroke:#2ca02c,stroke-width:2px;
    
    linkStyle 0 stroke:#1f77b4,stroke-width:2px
    linkStyle 1 stroke:#1f77b4,stroke-width:2px
    linkStyle 2 stroke:#ff0000,stroke-width:2px
    linkStyle 3 stroke:#ff0000,stroke-width:2px
    linkStyle 4 stroke:#1f77b4,stroke-width:2px
    linkStyle 5 stroke:#1f77b4,stroke-width:2px
    linkStyle 6 stroke:#2ca02c,stroke-width:2px
```

🔑 **Legend:**

* Blue path → Web traffic
* Red path → Database queries
* Green path → Infrastructure management

<br>

## 📸 <a id="screenshots">Screenshots</a>

<p align="center">
  <img src="assets/wordpress_setup.png" width="45%"/>  
  <img src="assets/wordpress_dashboard.png" width="45%"/>  
</p>

<p align="center">
  <img src="assets/static_site.png" width="45%"/>  
  <img src="assets/ftp_login.png" width="45%"/>  
</p>

<p align="center">
  <img src="assets/adminer.png" width="45%"/>  
  <img src="assets/portainer.png" width="45%"/>  
</p>

<p align="center">
  <img src="assets/self_signed_certificate.png" width="60%"/>  
</p>

<br>

## 🎥 <a id="demo">Demo</a>

<p align="center">
  <img src="assets/make_and_make_fclean.gif" width="90%"/>  
</p>

<br>

## 🏆 <a id="grade">Grade</a>

<p align="center">
  <img src="assets/Grade.png" width="100%"/>  
</p>

<br>

## 👨‍💻 <a id="author">Author</a>

**Achraf Lassiqui** – [@alassiqu](https://github.com/lassachraf)

<br>

## ⭐ <a id="support">Support</a>

If you found this project useful or inspiring, consider giving it a **star** ⭐ on GitHub!

<p align="center">
    <a src="https://github.com/lassachraf/Ineption">
    <img src="https://img.shields.io/github/stars/alassiqu/inception?style=social" />
    </a>
</p>
