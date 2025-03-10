# Frappe Bench Automated Setup Script

## Overview
This script automates the installation and setup of multiple Frappe Bench environments on an Ubuntu server. It checks for existing dependencies, installs missing packages, sets up MariaDB, configures Node.js and Pyenv, and installs ERPNext in separate benches.

## Features
- Checks and installs missing dependencies
- Installs and configures MariaDB securely
- Installs Node.js, Yarn, and Pyenv
- Creates multiple benches for Frappe (v13, v14, v15)
- Sets up Supervisor and Nginx configurations
- Installs ERPNext in each bench
- Creates sites with SSL (using Certbot)
- Configures and enables UFW firewall
- Restarts required services

## Prerequisites
Ensure that your system meets the following requirements:
- Ubuntu 20.04 or 22.04
- Root or sudo access
- Internet connection

## Installation & Usage
### Step 1: Download the Script
```bash

```

### Step 2: Make the Script Executable
```bash
chmod +x frappe_bench.sh
```

### Step 3: Run the Script
```bash
sudo ./frappe_bench.sh
```

## Configuration Details
- **MariaDB Root Password:** Set during installation
- **Bench Directories:** Created as `bench-13`, `bench-14`, `bench-15`
- **Sites Created:** `nextash-v13`, `nextash-v14`, `nextash-v15`
- **Firewall Rules:** Allows OpenSSH, HTTP (80), and HTTPS (443)

## Troubleshooting
- If MariaDB setup fails, run `sudo mysql_secure_installation` manually.
- If Bench initialization fails, check permissions with `sudo chmod -R 777 /home/$USER/bench-*`
- If Nginx fails to restart, verify configuration using `sudo nginx -t`

## License
This script is open-source and free to use under the MIT License.

## Author
Developed by NexTash.

