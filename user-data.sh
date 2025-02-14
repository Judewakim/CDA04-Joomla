#!/bin/bash

sudo apt update


sudo apt install -y apache2 php libapache2-mod-php php-mysql php-xml php-gd unzip

sudo systemctl start apache2
sudo systemctl enable apache2

cd /var/www/html
sudo curl -L -o joomla.zip https://github.com/joomla/joomla-cms/releases/download/3.9.28/Joomla_3.9.28-Stable-Full_Package.zip

sudo unzip joomla.zip

sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

sudo rm /var/www/html/index.html


sudo nano /etc/apache2/mods-enabled/dir.conf

DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm

sudo systemctl restart apache2