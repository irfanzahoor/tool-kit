# Automated Software Installation Script

This script automates the installation of essential software on Ubuntu, making it easier to set up a new system quickly.

## Features
- Installs development tools like VS Code, Git, and Postman.
- Installs essential applications like Google Chrome, AnyDesk, Zoom, VLC, and OBS Studio.
- Sets up system utilities like Docker, Htop, Neofetch, and BleachBit.
- Ensures a streamlined and efficient setup process.

## Prerequisites
- Ubuntu 20.04 or 22.04 (other versions may work but are untested).
- Root or sudo privileges.

## Installation
1. Clone this repository:
   ```bash
 git clone git@github.com:irfanzahoor/tool-kit.git

   ```
2. Navigate to the script directory:
   ```bash
   cd tool-kit
   cd applications
   ```
3. Make the script executable:
   ```bash
   chmod +x applications.sh
   ```
4. Run the script:
   ```bash
   ./applications.sh
   ```

## Usage
- Run the script on a fresh Ubuntu installation to set up all required applications in one go.
- The script will check for existing installations and skip already installed applications.

## Notes
- The script downloads and installs software packages directly from official sources.
- Some applications (like Postman) are installed manually using tar extraction.
- Docker installation is included but requires additional configuration for non-root usage.

## Contributing
Feel free to submit pull requests for improvements or additional software suggestions.

## License
This project is licensed under the MIT License.


## Author
Developed by NexTash.

