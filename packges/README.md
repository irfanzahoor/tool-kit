 # Automated Package Installation Script

## Overview
This script automates the installation of essential packges on a Debian-based Linux system. It checks whether each package is already installed and only installs missing ones, ensuring efficiency.

## Features
- Updates and upgrades system packages before installation.
- Installs popular packges including VS Code, Google Chrome, AnyDesk, VLC, Git, Docker, and more.
- Checks if a package is already installed before attempting to install it.
- Provides user-friendly messages for installation status.

## Prerequisites
- A Debian-based Linux distribution (e.g., Ubuntu, Linux Mint, Pop!_OS).
- Root or sudo privileges.
- An active internet connection.

## How to Use
1. **Download the script:**
   ```sh
 git clone git@github.com:irfanzahoor/tool-kit.git
   ```
```sh
cd tool-kit
   cd packges
```
 Run the script:
   ```bash
   ./applictains.sh
   ```

## packges Installed
- **Code Editors & Dev Tools:**
  - Visual Studio Code
  - Git
  - Docker
- **Web Browsers:**
  - Google Chrome
- **Remote Access:**
  - AnyDesk
- **Media & Streaming:**
  - VLC Media Player
  - OBS Studio
- **Utilities:**
  - Htop (System Monitor)
  - Neofetch (System Info Display)
  - BleachBit (System Cleaner)
  - Synaptic Package Manager
- **Productivity & Communication:**
  - Zoom
  - FileZilla (FTP Client)
  - Postman (API Testing)

## Troubleshooting
- If a package fails to install, run:
  ```sh
  sudo apt update --fix-missing
  ```
- If the script doesn’t execute, check permissions:
  ```sh
  ls -l install_packages.sh
  ```
  If needed, make it executable using `chmod +x install_packages.sh`.

## License
This script is provided under the MIT License. Feel free to modify and share.

## Author
Developed by NexTash.

