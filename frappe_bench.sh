#!/bin/bash

# Function to print messages with formatting
print_message() {
    echo -e "\n============================="
    echo "$1"
    echo -e "=============================\n"
    sleep 1
}

# Check if a package is installed
is_installed() {
    dpkg -l | grep -q "$1"
}

# Warning about MariaDB version compatibility
print_message "Checking MariaDB version compatibility..."
MARIADB_VERSION=$(mariadb --version 2>/dev/null | grep -oP '([0-9]+)\.([0-9]+)' | head -n 1)
if [[ -z "$MARIADB_VERSION" ]]; then
    echo "MariaDB is not installed!"
else
    echo "MariaDB Version: $MARIADB_VERSION"
    if [[ "$MARIADB_VERSION" < "10.6" ]]; then
        echo "Warning: MariaDB version is less than 10.6 which is not supported by Frappe."
    fi
fi

# Checking Ubuntu version
print_message "Checking Ubuntu version..."
UBUNTU_VERSION=$(lsb_release -rs)
echo "Ubuntu Version: $UBUNTU_VERSION"
if [[ "$UBUNTU_VERSION" != "20.04" && "$UBUNTU_VERSION" != "22.04" ]]; then
    echo "This script is optimized for Ubuntu 20.04 & 22.04. Some steps may not work on other versions."
fi

# Update & Upgrade System
print_message "Updating and upgrading system packages..."
sudo apt update && sudo apt upgrade -y

# Install Required Dependencies
DEPENDENCIES=("git" "libffi-dev" "python3-pip" "python3-dev" "python3-testresources" "libssl-dev" "wkhtmltopdf" "gcc" "g++" "make" "redis-server" "curl" "xvfb" "libfontconfig" "certbot" "python3-certbot-nginx" "shc" "ufw" "fail2ban")

print_message "Installing required dependencies..."
for package in "${DEPENDENCIES[@]}"; do
    if ! is_installed "$package"; then
        sudo apt-get install -y "$package"
    else
        echo "$package is already installed. Skipping..."
    fi
done

# Install MariaDB if not installed
if ! is_installed "mariadb-server"; then
    print_message "Installing MariaDB Server..."
    sudo apt-get install -y mariadb-server mariadb-client
    sudo systemctl enable --now mariadb

    print_message "Securing MariaDB..."
    sudo mysql_secure_installation
else
    echo "MariaDB is already installed. Skipping..."
fi

# Install Node.js & Yarn
if ! command -v node &> /dev/null; then
    print_message "Installing Node.js and Yarn..."
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    sudo apt-get install -y nodejs
    sudo npm install -g yarn
else
    echo "Node.js is already installed. Skipping..."
fi

# Install Pyenv if not installed
if [[ ! -d "$HOME/.pyenv" ]]; then
    print_message "Installing Pyenv..."
    curl https://pyenv.run | bash
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init -)"
    source ~/.bashrc
else
    echo "Pyenv is already installed. Skipping..."
fi

# Install Python Versions via Pyenv
PYTHON_VERSIONS=("3.7.1" "3.10.1" "3.11.9")
for version in "${PYTHON_VERSIONS[@]}"; do
    if ! pyenv versions | grep -q "$version"; then
        print_message "Installing Python $version for Frappe..."
        pyenv install "$version"
    else
        echo "Python $version is already installed. Skipping..."
    fi
done

# Install Frappe Bench if not installed
if ! command -v bench &> /dev/null; then
    print_message "Installing Frappe Bench..."
    sudo pip3 install frappe-bench
else
    echo "Frappe Bench is already installed. Skipping..."
fi

# Create Benches
for version in 13 14 15; do
    print_message "Creating Bench $version..."
    
    if [[ -d "bench-$version" ]]; then
        echo "Bench $version already exists. Skipping..."
        continue
    fi
    
    bench init "bench-$version" --frappe-branch "version-$version" --python "$HOME/.pyenv/versions/$([[ "$version" -eq 13 ]] && echo "3.7.1" || ([[ "$version" -eq 14 ]] && echo "3.10.1" || echo "3.11.9"))/bin/python"
    
    if [ $? -ne 0 ]; then
        echo "Error: Bench initialization failed for version $version. Check logs."
        exit 1
    fi
    
    cd "bench-$version"
    bench setup supervisor
    bench setup nginx
    
    sudo ln -sf "$(pwd)/config/supervisor.conf" "/etc/supervisor/conf.d/frappe-bench-$version.conf"
    sudo ln -sf "$(pwd)/config/nginx.conf" "/etc/nginx/sites-enabled/frappe-bench-$version"
    
    sudo systemctl restart nginx || echo "Warning: Nginx restart failed!"
    
    cd ..
done

# Install ERPNext in Each Bench and Create Sites
for version in 13 14 15; do
    print_message "Installing ERPNext in Bench $version..."
    cd "bench-$version" || { echo "Error: bench-$version not found!"; exit 1; }

    if [[ ! -d "apps/erpnext" ]]; then
        bench get-app erpnext --branch "version-$version"
    else
        echo "ERPNext is already installed in Bench $version. Skipping..."
    fi
    
    if [[ ! -d "sites/nextash-v$version" ]]; then
        bench new-site "nextash-v$version" --admin-password admin --mariadb-root-password root
        bench --site "nextash-v$version" install-app erpnext
        sudo certbot --nginx -d "nextash-v$version.local" --non-interactive --agree-tos --email "admin@nextash.com"
    else
        echo "Site nextash-v$version already exists. Skipping..."
    fi

    cd ..
done

# Enable UFW Firewall
print_message "Setting up firewall rules..."
sudo ufw allow OpenSSH
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable

# Restart Services
print_message "Restarting services..."
sudo systemctl restart nginx redis supervisor mariadb

print_message "Frappe Bench Setup Completed Successfully!"

