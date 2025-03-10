# Frappe Bench & Essential packges Installation

## Overview
This repository contains Bash scripts for setting up a Frappe Bench environment and installing essential packges on an Ubuntu system. The scripts automate the installation of necessary dependencies, packges, and system configurations.

## Features
- **Frappe Bench Setup**: Installs and configures Frappe Bench for versions 14 and 15.
- **Essential packges**: Installs development tools, system utilities, and productivity packges.
- **Automated Configuration**: Sets up MariaDB, Node.js, Git, Docker, and more.
- **Firewall & Security**: Configures UFW firewall and secures MariaDB.

## Installation
### Prerequisites
- Ubuntu 20.04 or 22.04 (recommended)
- User with sudo privileges

### Clone the Repository
```sh
git clone git@github.com:irfanzahoor/tool-kit.git

```
### Run the Installation Scripts
#### 1. Install Frappe Bench & ERPNext
```sh
cd tool-kit
cd bench_setup
chmod +x bench_setup.sh

./frappe_bench.sh
```

#### 2. Install Essential packges
```sh
cd tool-kit
   cd packges
```
 Run the script:
   ```bash
   ./packges.sh
   ```
## packges Installed
### Development Tools
- **VS Code** - Code editor
- **Postman** - API testing
- **Git** - Version control
- **Docker** - Containerization platform
- **FileZilla** - FTP client

### System Utilities
- **Neofetch** - System information tool
- **Htop** - Process monitoring
- **BleachBit** - System cleaner
- **Synaptic** - GUI package manager

### Productivity & Communication
- **Google Chrome** - Web browser
- **AnyDesk** - Remote desktop tool
- **Zoom** - Video conferencing
- **VLC** - Media player
- **OBS Studio** - Screen recording & streaming
- **GIMP** - Image editor

## Post-Installation Steps
1. **Restart your system** to apply changes.


