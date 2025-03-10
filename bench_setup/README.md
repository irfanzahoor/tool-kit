# Welcome to the Frappe Bench Setup Repository

This repository contains a Bash script to automate the installation and setup of Frappe Bench versions 14 and 15 on Ubuntu 20.04 and 22.04.

## Features
- Installs all necessary dependencies
- Sets up MariaDB, Node.js, Redis, and other required services
- Installs Frappe Bench and initializes separate benches for version 14 and 15
- Creates ERPNext sites automatically
- Configures firewall and restarts essential services

## Prerequisites
Ensure your system meets the following requirements:
- Ubuntu 20.04 or 22.04
- At least 4GB RAM (8GB recommended)
- Root or sudo access

## Installation
Clone this repository and execute the setup script:
```bash
sudo apt update && sudo apt install -y git

git clone git@github.com:irfanzahoor/tool-kit.git
cd tool-kit
cd bench_setup

chmod +x bench_setup.sh
./frappe_bench.sh
```

## Usage
After installation, you can start using your benches:
```bash
cd bench-14
bench start
```
Or for Bench 15:
```bash
cd bench-15
bench start
```

## Contributing
Feel free to open issues or submit pull requests to improve this script!

## License
This project is licensed under the MIT License.


## Author
Developed by NexTash.

