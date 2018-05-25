#!/bin/bash
sudo apt-get update && sudo apt-get -y upgrade
wget https://download.teamviewer.com/download/linux/teamviewer-host_armhf.deb
sudo dpkg -i teamviewer-host_armhf.deb
sudo apt-get -f install --yes
read -p "Enter Your Teamviewer LAN Password: "  password
sudo teamviewer setup && sudo teamviewer passwd $password && sudo rm teamviewer-host_armhf.deb*
