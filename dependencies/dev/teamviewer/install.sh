#!/bin/bash
sudo apt-get update && sudo apt-get -y upgrade
wget https://download.teamviewer.com/download/linux/teamviewer-host_armhf.deb
sudo dpkg -i teamviewer-host_armhf.deb
sudo apt-get -f install --yes
while true; do
    read -s -p "Create Your Teamviewer LAN Password: " pswd
    echo
    read -s -p "Re-Enter Your Teamviewer LAN Password: " pswd1
    echo
    [ "$pswd" = "$pswd1" ] && break
    echo "Passwords don't match. Please try again"
done
sudo teamviewer passwd $pswd1 && sudo teamviewer setup && sudo rm teamviewer-host_armhf.deb*
