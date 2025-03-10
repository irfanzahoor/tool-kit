#!/bin/bash

# Function to print messages with formatting
print_message() {
    echo -e "\n============================="
    echo "$1"
    echo -e "=============================\n"
    sleep 1
}

# Update & Upgrade System
print_message "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install VS Code
print_message "Installing Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/packages.microsoft.gpg > /dev/null
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update && sudo apt install -y code

# Install Google Chrome
print_message "Installing Google Chrome..."
wget -qO google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome.deb
rm google-chrome.deb


# Install AnyDesk
print_message "Installing AnyDesk..."
wget -qO- https://keys.anydesk.com/repos/DEB-GPG-KEY | gpg --dearmor | sudo tee /usr/share/keyrings/anydesk.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk.list
sudo apt update && sudo apt install -y anydesk

# Install VLC Media Player
print_message "Installing VLC Media Player..."
sudo apt install -y vlc

# Install GIMP (Image Editor)
print_message "Installing GIMP..."
sudo apt install -y gimp

# Install OBS Studio (Screen Recorder & Streaming)
print_message "Installing OBS Studio..."
sudo apt install -y obs-studio

# Install Postman (API Testing)
print_message "Installing Postman..."
wget -qO postman.tar.gz https://dl.pstmn.io/download/latest/linux_64
sudo tar -xzf postman.tar.gz -C /opt
sudo ln -s /opt/Postman/Postman /usr/local/bin/postman
rm postman.tar.gz


# Install Zoom
print_message "Installing Zoom..."
wget -qO zoom.deb https://zoom.us/client/latest/zoom_amd64.deb
sudo apt install -y ./zoom.deb
rm zoom.deb



# Install FileZilla (FTP Client)
print_message "Installing FileZilla..."
sudo apt install -y filezilla

# Install Git
print_message "Installing Git..."
sudo apt install -y git

# Install Docker
print_message "Installing Docker..."
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

# Install Htop (System Monitoring Tool)
print_message "Installing Htop..."
sudo apt install -y htop

# Install Neofetch (System Info Display)
print_message "Installing Neofetch..."
sudo apt install -y neofetch

# Install BleachBit (System Cleaner)
print_message "Installing BleachBit..."
sudo apt install -y bleachbit

# Install Synaptic (GUI Package Manager)
print_message "Installing Synaptic Package Manager..."
sudo apt install -y synaptic

print_message "All essential applications installed successfully!"
