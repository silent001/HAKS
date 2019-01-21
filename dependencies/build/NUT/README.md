# Network UPS Tools (NUT)
This is the core of the UPS monitoring for this build

To get PyNUT to work with python3 after running `sudo apt-get install python-nut`in the terminal run the following command:

```console
sudo ln -sf /usr/share/pyshared/PyNUT.py /usr/lib/python3/dist-packages/PyNUT.py
```

This will create a symbolic link from where the apt package PyNUT file has been installed to the modules directory of python3 like the installer does for python2.7

The PyNUT module claims to be compatible with python3

##### Table of Contents
* [Installation](#installation)
   * [Select your driver](#select-your-driver)
   * [Configure the UPS](#configure-the-ups)
   * [Create udev USB Rule](#create-udev-usb-rule)
   * [Setup NUT Server](#setup-nut-server)
* [To Do](#to-do)
* [Sources](#sources)

## Installation
From a terminal window enter the following:

```console
sudo apt-get update && sudo apt-get install nut nut-client nut-monitor nut-server -y
```
### Select your driver
Before continuing please go to this link and take a note of the driver that is required for your specific UPS [here](http://www.networkupstools.org/stable-hcl.html) and make a note of the recommended driver name, this will be used later.

### Configure the UPS
Now we need to edit and configure the UPS for NUT to know how to communicate to the UPS correctly. Run the following command from a terminal:   
###### Using GUI over TeamViewer or VNC Viewer:

```console
sudo leafpad /etc/nut/ups.conf
```
###### Using ssh over putty or similar:
```console
sudo nano /etc/nut/ups.conf
```
Once it is open in the editor you need to add in the following lines:
```
[{friendly name(no Spaces)}]
   driver = "{driver}"
   port = auto
   desc = "{UPS description}"
```
###### eg.
```
[havok]
   driver = "blazer_usb"
   port = auto
   desc = "ME-2000-VU 2000VA/1200W Line Interactive UPS"
```
Repalce everything within {} with the details you want keeping in mind that the {driver} is the driver you found from NUT's website. The name for your UPS needs to be noted down for the rest of the steps.   
Close and save the file (ctrl-x, y, enter if using nano) or (ctrl-s,ctrl-q if using leafpad).

### Create udev USB Rule
From a terminal window enter the following:
```console
lsusb
```
The output should be something similar to the below:
```console
pi@raspberrypi:~ $ lsusb
Bus 001 Device 004: ID 0665:5161 Cypress Semiconductor USB to Serial
Bus 001 Device 003: ID 0424:ec00 Standard Microsystems Corp. SMSC9512/9514 Fast Ethernet Adapter
Bus 001 Device 002: ID 0424:9514 Standard Microsystems Corp. SMC9514 Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
pi@raspberrypi:~ $ 
```
Look at the ID that looks like it could be your UPS. Mine is this line `Bus 001 Device 004: ID 0665:5161 Cypress Semiconductor USB to Serial` so the details I need from here is `0665:5161`.
Once you have the ID noted for your UPS then run the following command:
###### Using GUI over TeamViewer or VNC Viewer:

```console
sudo leafpad /etc/udev/rules.d/98-friendly name(no Spaces).rules
```
###### eg.
```console
sudo leafpad /etc/udev/rules.d/98-havok.rules
```
###### Using ssh over putty or similar:
```console
sudo nano /etc/udev/rules.d/98 -friendly name(no Spaces).rules
```
###### eg.
```console
sudo leafpad /etc/udev/rules.d/98-havok.rules
```
Once it is open in the editor you need to add in the following lines:
```
SYSFS{idVendor}=='0065', SYSFS{idProduct}=='5161', MODE='0666'
```
substituting in your own device ID inside the quotes for {idVender} and {idProduct}.   
Close and save the file (ctrl-x, y, enter if using nano) or (ctrl-s,ctrl-q if using leafpad).

### Setup NUT Server
Run the following command from a terminal window:
###### Using GUI over TeamViewer or VNC Viewer:

```console
sudo leafpad /etc/nut/nut.conf
```
###### Using ssh over putty or similar:
```console
sudo nano /etc/nut/nut.conf
```
Once it is open in the editor you need to add in the following lines:
```
MODE=standalone
```
If you are only going to need the NUT server on your local system then `standalone` is fine however if you have other devices connected to the UPS that need to safely shutdown then you need to have it set to `netserver`.   
Close and save the file (ctrl-x, y, enter if using nano) or (ctrl-s,ctrl-q if using leafpad).
## To Do
- [ ] Move this section out to a separate file
- [ ] Create a bash script to automate most of the install and setup process
- [ ] Complete the README.md to document a manual installation of the NUT system

## Sources
* [Raspberry Pi Home Server v2: Network UPS Tools](https://melgrubb.com/2016/12/11/rphs-v2-ups/)
* [Raspberry Pi UPS monitor (with Nginx web monitoring)](https://loganmarchione.com/2017/02/raspberry-pi-ups-monitor-with-nginx-web-monitoring/)
