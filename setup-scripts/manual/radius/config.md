# How to configure my sql for radius
https://bytexd.com/freeradius-ubuntu/

sudo mysql -u root -p
```
CREATE DATABASE radius;
CREATE USER 'radius'@'localhost' IDENTIFIED by 'Somestrongpassword_321';
GRANT ALL PRIVILEGES ON radius.* TO 'radius'@'localhost';
FLUSH PRIVILEGES;
quit;
```
`sudo su -`

`mysql -u root -p radius < /etc/freeradius/3.0/mods-config/sql/main/mysql/schema.sql`

`exit`

`sudo mysql -u root -p -e "use radius;show tables;"`

`sudo ln -s /etc/freeradius/3.0/mods-available/sql /etc/freeradius/3.0/mods-enabled/`

I backed up the sql config file in this folder
copy it to

`sudo cp ./sql /etc/freeradius/3.0/mods-enabled/sql`

`sudo chgrp -h freerad /etc/freeradius/3.0/mods-available/sql`

`sudo chown -R freerad:freerad /etc/freeradius/3.0/mods-enabled/sql`


`wget https://github.com/lirantal/daloradius/archive/master.zip`

`unzip master.zip`

`cd daloradius-master`

`sudo mysql -u root -p radius < contrib/db/fr2-mysql-daloradius-and-freeradius.sql`

`sudo mysql -u root -p radius < contrib/db/mysql-daloradius.sql`

`cd ..`

`sudo mv daloradius-master /var/www/html/daloradius`

`sudo chown -R www-data:www-data /var/www/html/daloradius/`

`sudo cp /var/www/html/daloradius/library/daloradius.conf.php.sample /var/www/html/daloradius/library/daloradius.conf.php`

`sudo chmod 664 /var/www/html/daloradius/library/daloradius.conf.php`

Modify /var/www/html/daloradius/library/daloradius.conf.php
it's saved in this folder

`sudo cp ./daloradius.conf.php /var/www/html/daloradius/library/daloradius.conf.php`


`sudo systemctl restart freeradius.service apache2`

Visit  http://localhost/daloradius