#!/bin/bash
# https://bytexd.com/freeradius-ubuntu/

# install apache
sudo apt -yy install apache2
sudo systemctl enable --now apache2
sudo ufw allow WWW
sudo apt-get install -yy freeradius freeradius-mysql freeradius-utils
# install php, it's for dolaris radius GUI
sudo apt -y install php libapache2-mod-php php-{gd,common,mail,mail-mime,mysql,pear,db,mbstring,xml,curl}
# install MariaDb
sudo apt -y install mariadb-server
sudo mysql_secure_installation
# install radius
sudo systemctl enable --now freeradius
# enable port
sudo ufw allow to any port 1812 proto udp
sudo ufw allow to any port 1813 proto udp
# https://bytexd.com/freeradius-ubuntu/
