#!/bin/bash
sudo apt-get update && sudo apt-get upgrade
wget https://download.teamviewer.com/download/linux/teamviewer-host_armhf.deb
sudo dpkg -i teamviewer-host_armhf.deb
sudo apt-get -f install
sudo teamviewer setup
sudo teamviewer passwd