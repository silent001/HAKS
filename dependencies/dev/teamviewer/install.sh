#!/bin/bash
sudo apt-get update && sudo apt-get -y upgrade
wget https://download.teamviewer.com/download/linux/teamviewer-host_armhf.deb
sudo dpkg -i teamviewer-host_armhf.deb
sudo apt-get -f install --yes
read -s -p "Create Your Teamviewer LAN Password: "  pswd
read -s -p "Re-Enter Your Teamviewer LAN Password: "  pswd1
#Here will go a if function to test if passwords match
sudo teamviewer setup && sudo teamviewer passwd $pswd && sudo rm teamviewer-host_armhf.deb*
