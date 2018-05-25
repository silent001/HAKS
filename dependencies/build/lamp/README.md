# LAMP INSTALL
```
sudo apt-get -y install apache2 mysql-server mysql-client php7.0 libapache2-mod-php7.0
sudo mysql_secure_installation
sudo mysql -u root
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'SecurePassword';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
exit
```
