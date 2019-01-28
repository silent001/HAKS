#!/usr/bin/env bash
# Find the rows and columns. Will default to 80x24 if it can not be detected.
screen_size=$(stty size 2>/dev/null || echo 24 80)
rows=$(echo $screen_size | awk '{print $1}')
columns=$(echo $screen_size | awk '{print $2}')

# Divide by two so the dialogs take up half of the screen, which looks nice.
r=$(( rows / 2 ))
c=$(( columns / 2 ))
# Unless the screen is tiny
r=$(( r < 20 ? 20 : r ))
c=$(( c < 70 ? 70 : c ))
backtitle="Project H.A.K.S"
title="NUT Easy Installer"

function CreateUPS() {
	while [ -z "$UPSName" ]; do
		UPSName=$(whiptail --title "${title}" --backtitle "${backtitle}" --inputbox "What do you want to call your UPS?\n\n*No spaces allowed" ${r} ${c} havok 3>&1 1>&2 2>&3) || \
		CancelInstall
		# TODO: Add in function to remove trailing spaces
		# TODO: Add in function to check if input contains spaces
    done
    while [ -z "$Driver" ]; do
		Driver=$(whiptail --title "${title}" --backtitle "${backtitle}" --inputbox "What driver should be used?\n\n*Go to http://www.networkupstools.org/stable-hcl.html " ${r} ${c} blazer_usb 3>&1 1>&2 2>&3) || \
		CancelInstall
		# TODO: Add in function to validate driver with list from NUT
    done
    while [ -z "$Desc" ]; do
		Desc=$(whiptail --title "${title}" --backtitle "${backtitle}" --inputbox "What description do you want to use for this UPS?" ${r} ${c} "ME-2000-VU 2000VA/1200W Line Interactive UPS" 3>&1 1>&2 2>&3) || \
		CancelInstall
    done
    #echo -e "[${UPSName}]\n\tdriver = \"${Driver}\"\n\tport = auto\n\tdesc = \"${Desc}\""
    if !(whiptail --title "${title}" --backtitle "${backtitle}" --yesno "Does the below look correct?\n\n[${UPSName}]\n    driver = \"${Driver}\"\n    port = auto\n    desc = \"${Desc}\"" ${r} ${c}); then
		unset UPSName; unset Driver; unset Desc
		CreateUPS
	fi
}
function USBList() {
	# TODO: Attempt tp auto detect USB for UPS using a snap of USB device before and after pluging in the UPS. 
	# Default to below if detection fails for some reason
	while [ -z "$device_id" ]; do
		device_id=$(
		declare -a array=()
		while read foo{,,,,} id dsc;do
			array+=($id "$dsc")
		  done < <(lsusb)
		whiptail --title "${title}" --backtitle "${backtitle}" --menu 'Select USB device' ${r} ${c} 12 "${array[@]}" 3>&1 1>&2 2>&3) || \
		CancelInstall
	done
}
function NUTMode() {
	echo "Set MODE=$1 inside nut.conf"
	# Avalible modes are none, standalone, netserver and netclient.
	if [ "$1" = "standalone" ] || [ "$1" = "netserver" ]; then
		USBList
		# If USB item is found then only continue else exit
		# TODO: Check if apt-get upgrade has recently been run
		echo "sudo apt-get update && sudo apt-get install nut nut-client nut-monitor nut-server -y"
		CreateUPS
		echo "sudo leafpad /etc/udev/rules.d/98-${UPSName}.rules"
		echo "Populate $device_id inside SYSFS{idVendor}=='0065', SYSFS{idProduct}=='5161', MODE='0666'"
	fi
}
function CancelInstall() {
	if (whiptail --title "${title}" --backtitle "${backtitle}" --yesno "Do you wish to cancel the installer?" ${r} ${c}); then
		echo "Exiting installer."
		exit 3
	else
		#echo "Go back to last process ${1}"
		[ ! -z "$1" ] && $1
	fi
}
function MainMenu() {
	option=$(whiptail --title "${title}" --backtitle "${backtitle}" --menu "Choose an install option" ${r} ${c} 6 \
	"Standalone" "Install on only this system." \
	"Server" "Install for access from another system." \
	"Client" "Install to access a NUT server." \
	"${1}" "${2}" 3>&1 1>&2 2>&3)
	
	# Avalible modes are none, standalone, netserver and netclient.
	if [ "$option" = "Standalone" ]; then
		NUTMode standalone
	elif [ "$option" = "Server" ]; then
		NUTMode netserver
	elif [ "$option" = "Client" ]; then
		NUTMode netclient
	elif [ "$option" = "Done" ]; then
		exit 0
	else
		CancelInstall MainMenu
	fi
}
whiptail --title "${title}" --backtitle "${backtitle}" --msgbox "This installer will guide you throught the Network UPS Tools(NUT) install process.\n\nPlease note this is still a WIP(Work In Progress) so it might still have some bugs." ${r} ${c}
MainMenu
