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

# Checking Ubuntu version
print_message "Checking Ubuntu version..."
UBUNTU_VERSION=$(lsb_release -rs)
echo "Ubuntu Version: $UBUNTU_VERSION"
if [[ "$UBUNTU_VERSION" != "20.04" && "$UBUNTU_VERSION" != "22.04" ]]; then
    echo "Warning: This script is optimized for Ubuntu 20.04 & 22.04."
fi

# Update & Upgrade System
print_message "Updating and upgrading system packages..."
sudo apt update && sudo apt upgrade -y

# Install Required Dependencies
DEPENDENCIES=("git" "libffi-dev" "python3-pip" "python3-dev" "libssl-dev" "wkhtmltopdf" "gcc" "g++" "make" "redis-server" "curl" "xvfb" "libfontconfig" "certbot" "python3-certbot-nginx" "ufw" "fail2ban" "python3-venv" "build-essential")

print_message "Installing required dependencies..."
for package in "${DEPENDENCIES[@]}"; do
    if ! is_installed "$package"; then
        sudo apt-get install -y "$package"
    else
        echo "$package is already installed. Skipping..."
    fi
done

# Install MariaDB
if ! is_installed "mariadb-server"; then
    print_message "Installing MariaDB Server..."
    sudo apt-get install -y mariadb-server mariadb-client
    sudo systemctl enable --now mariadb
    
    print_message "Securing MariaDB..."
    sudo mysql_secure_installation <<EOF
    y
    n
    y
    y
    y
    y
EOF
else
    echo "MariaDB is already installed. Skipping..."
fi

# Install Node.js & Yarn
if ! command -v node &> /dev/null; then
    print_message "Installing Node.js and Yarn..."
    curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
    sudo apt-get install -y nodejs
    sudo npm install -g yarn
else
    echo "Node.js is already installed. Skipping..."
fi

# Install Pyenv
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
PYTHON_VERSION="3.10.1"
if ! pyenv versions | grep -q "$PYTHON_VERSION"; then
    print_message "Installing Python $PYTHON_VERSION..."
    pyenv install "$PYTHON_VERSION"
else
    echo "Python $PYTHON_VERSION is already installed. Skipping..."
fi

# Install Frappe Bench
if ! command -v bench &> /dev/null; then
    print_message "Installing Frappe Bench..."
    pip3 install --user --upgrade frappe-bench
    export PATH="$HOME/.local/bin:$PATH"
    source ~/.bashrc
else
    echo "Frappe Bench is already installed. Skipping..."
fi

# Create Benches
for BENCH_NAME in "bench-14" "bench-15"; do
    if [[ -d "$BENCH_NAME" ]]; then
        echo "$BENCH_NAME already exists. Skipping..."
    else
        print_message "Creating Bench $BENCH_NAME..."
        bench init "$BENCH_NAME" --frappe-branch version-${BENCH_NAME##bench-} --python "$(pyenv root)/versions/$PYTHON_VERSION/bin/python"
        cd "$BENCH_NAME"
        bench setup supervisor
        bench setup nginx
        
        sudo ln -sf "$(pwd)/config/supervisor.conf" "/etc/supervisor/conf.d/$BENCH_NAME.conf"
        sudo ln -sf "$(pwd)/config/nginx.conf" "/etc/nginx/sites-enabled/$BENCH_NAME"
        
        sudo systemctl restart nginx || echo "Warning: Nginx restart failed!"
        cd ..
    fi

    # Install ERPNext
    cd "$BENCH_NAME"
    if [[ ! -d "apps/erpnext" ]]; then
        print_message "Installing ERPNext..."
        bench get-app erpnext --branch version-${BENCH_NAME##bench-}
    else
        echo "ERPNext is already installed. Skipping..."
    fi

    # Create Site with dynamic site name and database name
    SITE_NAME="nextash-demo-${BENCH_NAME##bench-}"
    DB_NAME="nextash-demo-${BENCH_NAME##bench-}"

    if [[ ! -d "sites/$SITE_NAME" ]]; then
        print_message "Creating Site $SITE_NAME with database $DB_NAME..."
        bench new-site "$SITE_NAME" --admin-password admin --mariadb-root-password root --db-name "$DB_NAME"
        bench --site "$SITE_NAME" install-app erpnext
    else
        echo "Site $SITE_NAME already exists. Skipping..."
    fi
    cd ..
done

# Enable Firewall
print_message "Setting up firewall rules..."
sudo ufw allow OpenSSH
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw --force enable

# Restart Services
print_message "Restarting services..."
sudo systemctl restart nginx redis supervisor mariadb

print_message "Frappe Bench Setup Completed Successfully!"

