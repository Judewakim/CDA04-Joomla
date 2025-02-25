#!/bin/bash

# ssh into instance

# update and install dependencies
sudo apt update && sudo apt upgrade -y

sudo apt install -y apache2 php libapache2-mod-php php-mysql php-cli php-curl php-gd php-mbstring php-xml php-xmlrpc unzip git
sudo apt install -y mysql-client

# create rds in aws

# connect to rds. THIS LINE MAY NOT WORK BC OF THE PASSWORD WHICH NEEDS TO BE MANUALLY ENTERED
mysql -h {YOUR-RDS-ENDPOINT} -u {USERNAME} -p {PASSWORD}

# create database inside rds
CREATE DATABASE wordpress_db;
CREATE USER 'wordpress_user'@'%' IDENTIFIED BY 'your-secure-password';
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wordpress_user'@'%';
FLUSH PRIVILEGES;
EXIT;

# go to web root directory
cd /var/www/html

# remove index.html
sudo rm index.html

# clone wordpress repo from github
sudo git clone https://github.com/WordPress/WordPress.git wordpress

# set permissions
sudo chown -R www-data:www-data /var/www/html/wordpress
sudo chmod -R 755 /var/www/html/wordpress

# add config into wordpress.conf
echo '<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html/wordpress
    <Directory /var/www/html/wordpress>
        AllowOverride All
    </Directory>
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' | sudo tee /etc/apache2/sites-available/wordpress.conf

# enable new site
sudo a2ensite wordpress.conf

# mod_rewrite
sudo a2enmod rewrite

# restart apache
sudo systemctl restart apache2

# rename the sample config file
sudo mv /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

# call the configure_wp_config.sh script, relatively bc they are in the same directory
echo "Configuring wp-config.php..."
./configure_wp_config.sh "$DB_NAME" "$DB_USER" "$DB_PASSWORD" "$DB_HOST"

#restart apache one last time
sudo systemctl restart apache2
