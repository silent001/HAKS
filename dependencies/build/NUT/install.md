# [SOURCE:](https://loganmarchione.com/2017/02/raspberry-pi-ups-monitor-with-nginx-web-monitoring/)
```
sudo apt-get update && sudo apt-get install nut nut-client nut-monitor nut-server -y
sudo leafpad /etc/nut/ups.conf
```
##### Select right Driver
> ```
> [friendly name(no Spaces)]
>    driver = "driver"
>    port = auto
>    desc = "Description type"
> ```
```
lsusb
```
##### note down ID
_ie ID 0665:5161_
```
sudo leafpad /etc/udev/rules.d/98 -friendly name(no Spaces).rules
```
> ```
> SYSFS{idVendor}=='0065', SYSFS{idProduct}=='5161', MODE='0666'
> ```
```
sudo systemctl start nut-driver
sudo systemctl status nut-driver
```

# SERVER SETUP
```
sudo leafpad /etc/nut/upsd.conf
```
##### Add LISTEN directive
> ```
> LISTEN 127.0.0.1 3493
> ```
```
sudo leafpad /etc/nut/upsd.users
```
#### Add admin and user
> ```
> [admin]
>        password = admin1
>        actions = SET
>        instcmds = ALL
> [upsmon_local]
>         password  = local1
>         upsmon master
> ```
##### Set mode
```
sudo leafpad /etc/nut/nut.conf
```
> ```
> MODE=standalone
> ```
##### Reboot now for changes to take affect
```
sudo reboot
```
##### check status
```
sudo systemctl start nut-server
sudo systemctl status nut-server
```
#### test connection via localhost
```
sudo upsc {friendly name@localhost}
```
#### CLIENT SETUP
```
sudo leafpad /etc/nut/upsmon.conf
```
> ```
> MONITOR friendly name@localhost 1 upsmon_local local1 master
> ```
##### ~~ownership and permissions~~ __Dont do this at all__
```diff
- chown -R root:nut /etc/nut/
- chmod -R 640 /etc/nut/
```

##### Start client and check status
```
sudo systemctl start nut-monitor
sudo systemctl status nut-monitor
```
#### test connection
```
sudo upsc friendly name@localhost
```
#### WEB MONITORING
```
sudo apt-get update && sudo apt-get install nut-cgi fcgiwrap -y
```

#### Add following line
```
sudo leafpad /etc/nut/hosts.conf
```
> ```
> MONITOR friendly name@localhost "Description type"
> ```
