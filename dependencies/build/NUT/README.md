# Network UPS Tools (NUT)
This is the core of the UPS monitoring for this build

To get PyNUT to work with python3 after running `sudo apt-get install python-nut`in the terminal run the following command:

```
sudo ln -sf /usr/share/pyshared/PyNUT.py /usr/lib/python3/dist-packages/PyNUT.py
```

This will create a symbolic link from where the apt package PyNUT file has been installed to the modules directory of python3 like the installer does for python2.7

The PyNUT module claims to be compatible with python3

##### Table of Contents
* [Installation](#installation)
   * [Select your driver](#select-your-driver)
   * [Configure the UPS](#configure-the-ups)
   * []()
* [Sources](#sources)

## Installation
From a terminal window enter the following:

```
sudo apt-get update && sudo apt-get install nut nut-client nut-monitor nut-server -y
```
### Select your driver
Before continuing please go to this link and take a note of the driver that is required for your specific UPS [here](http://www.networkupstools.org/stable-hcl.html) and make a note of the recommended driver name, this will be used later.

### Configure the UPS
Now we need to edit and configure the UPS for NUT to know how to communicate to the UPS correctly. Run the following command from a terminal:   
Using GUI over TeamViewer or VNC Viewer:

```
sudo leafpad /etc/nut/ups.conf
```
Using ssh over putty or similar:
```
sudo nano /etc/nut/ups.conf
```
Once it is open in the editor you need to add in the following lines:
```
[{friendly name(no Spaces)}]
   driver = "{driver}"
   port = auto
   desc = "{UPS description}"
```
Repalce everything within {} with the details you want keeping in mind that the {driver} is the driver you found from NUT's website.

## To Do
- [ ] Move this section out to a separate file
- [ ] Create a bash script to automate most of the install and setup process
- [ ] Complete the README.md to document a manual installation of the NUT system

## Sources
* [Raspberry Pi Home Server v2: Network UPS Tools](https://melgrubb.com/2016/12/11/rphs-v2-ups/)
