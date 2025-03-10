#!/bin/bash

# Function to print messages with formatting
print_message() {
    echo -e "\n============================="
    echo "$1"
    echo -e "=============================\n"
    sleep 1
}

# Function to check if a package is installed
is_installed() {
    dpkg -l | grep -q "^ii  $1 "
}

# Update & Upgrade System
print_message "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install VS Code
if ! is_installed "code"; then
    print_message "Installing Visual Studio Code..."
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/packages.microsoft.gpg > /dev/null
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
    sudo apt update && sudo apt install -y code
else
    print_message "VS Code is already installed!"
fi

# Install Google Chrome
if ! is_installed "google-chrome-stable"; then
    print_message "Installing Google Chrome..."
    wget -qO google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y ./google-chrome.deb
    rm google-chrome.deb
else
    print_message "Google Chrome is already installed!"
fi

# Install AnyDesk
if ! is_installed "anydesk"; then
    print_message "Installing AnyDesk..."
    wget -qO- https://keys.anydesk.com/repos/DEB-GPG-KEY | gpg --dearmor | sudo tee /usr/share/keyrings/anydesk.gpg > /dev/null
    echo "deb [signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk.list
    sudo apt update && sudo apt install -y anydesk
else
    print_message "AnyDesk is already installed!"
fi

# Install Tor Browser
if ! is_installed "torbrowser-launcher"; then
    print_message "Installing Tor Browser..."
    sudo apt install -y torbrowser-launcher
else
    print_message "Tor Browser is already installed!"
fi

# Install VLC Media Player
if ! is_installed "vlc"; then
    print_message "Installing VLC Media Player..."
    sudo apt install -y vlc
else
    print_message "VLC is already installed!"
fi

# Install GIMP (Image Editor)
if ! is_installed "gimp"; then
    print_message "Installing GIMP..."
    sudo apt install -y gimp
else
    print_message "GIMP is already installed!"
fi

# Install OBS Studio (Screen Recorder & Streaming)
if ! is_installed "obs-studio"; then
    print_message "Installing OBS Studio..."
    sudo apt install -y obs-studio
else
    print_message "OBS Studio is already installed!"
fi

# Install Postman (API Testing)
if ! is_installed "postman"; then
    print_message "Installing Postman..."
    wget -qO postman.tar.gz https://dl.pstmn.io/download/latest/linux_64
    sudo tar -xzf postman.tar.gz -C /opt
    sudo ln -s /opt/Postman/Postman /usr/local/bin/postman
    rm postman.tar.gz
else
    print_message "Postman is already installed!"
fi

# Install Zoom
if ! is_installed "zoom"; then
    print_message "Installing Zoom..."
    wget -qO zoom.deb https://zoom.us/client/latest/zoom_amd64.deb
    sudo apt install -y ./zoom.deb
    rm zoom.deb
else
    print_message "Zoom is already installed!"
fi

# Install FileZilla (FTP Client)
if ! is_installed "filezilla"; then
    print_message "Installing FileZilla..."
    sudo apt install -y filezilla
else
    print_message "FileZilla is already installed!"
fi

# Install Git
if ! is_installed "git"; then
    print_message "Installing Git..."
    sudo apt install -y git
else
    print_message "Git is already installed!"
fi

# Install Docker
if ! is_installed "docker.io"; then
    print_message "Installing Docker..."
    sudo apt install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
else
    print_message "Docker is already installed!"
fi

# Install Htop (System Monitoring Tool)
if ! is_installed "htop"; then
    print_message "Installing Htop..."
    sudo apt install -y htop
else
    print_message "Htop is already installed!"
fi

# Install Neofetch (System Info Display)
if ! is_installed "neofetch"; then
    print_message "Installing Neofetch..."
    sudo apt install -y neofetch
else
    print_message "Neofetch is already installed!"
fi

# Install BleachBit (System Cleaner)
if ! is_installed "bleachbit"; then
    print_message "Installing BleachBit..."
    sudo apt install -y bleachbit
else
    print_message "BleachBit is already installed!"
fi

# Install Synaptic (GUI Package Manager)
if ! is_installed "synaptic"; then
    print_message "Installing Synaptic Package Manager..."
    sudo apt install -y synaptic
else
    print_message "Synaptic is already installed!"
fi

print_message "All essential packages are installed successfully!"

