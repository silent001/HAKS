# Network UPS Tools (NUT)
This is the core of the UPS monitoring for this build

To get PyNUT to work with python3 after running `sudo apt-get install python-nut`in the terminal run the following command:

```
sudo ln -sf /usr/share/pyshared/PyNUT.py /usr/lib/python3/dist-packages/PyNUT.py
```

This will create a symbolic link from where the apt package PyNUT file has been installed to the modules directory of python3 like the installer does for python2.7

The PyNUT module claims to be compatible with python3
