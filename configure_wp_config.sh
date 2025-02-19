#!/bin/bash

# Check if the correct number of arguments are passed
if [ $# -ne 4 ]; then
    echo "Usage: $0 <DB_NAME> <DB_USER> <DB_PASSWORD> <DB_HOST>"
    exit 1
fi

# Get arguments passed to the script
DB_NAME=$1
DB_USER=$2
DB_PASSWORD=$3
DB_HOST=$4

# Path to wp-config.php
WP_CONFIG_PATH="/var/www/html/wordpress/wp-config.php"

# Ensure the wp-config.php file exists before proceeding
if [ -f "$WP_CONFIG_PATH" ]; then
    # Use sed to insert the database values into wp-config.php
    sudo sed -i "s/define( 'DB_NAME', 'database_name_here' );/define( 'DB_NAME', '$DB_NAME' );/" $WP_CONFIG_PATH
    sudo sed -i "s/define( 'DB_USER', 'username_here' );/define( 'DB_USER', '$DB_USER' );/" $WP_CONFIG_PATH
    sudo sed -i "s/define( 'DB_PASSWORD', 'password_here' );/define( 'DB_PASSWORD', '$DB_PASSWORD' );/" $WP_CONFIG_PATH
    sudo sed -i "s/define( 'DB_HOST', 'localhost' );/define( 'DB_HOST', '$DB_HOST' );/" $WP_CONFIG_PATH

    echo "wp-config.php has been updated with the database settings."
else
    echo "Error: wp-config.php file not found at $WP_CONFIG_PATH"
fi


sudo sed -i "s/define('DB_USER', 'username_here');/define('DB_USER', 'admin');/" /var/www/html/wordpress/wp-config.php
sudo sed -i "s#define( 'DB_USER', 'username_here' );#define( 'DB_USER', 'admin' );#" /var/www/html/wordpress/wp-config.php

sudo sed -i "s/define('DB_PASSWORD', 'password_here');/define('DB_PASSWORD', 'WCnTbRHMeo2W75Svco0C');/" /var/www/html/wordpress/wp-config.php
sudo sed -i "s/define('DB_HOST', 'localhost');/define('DB_HOST', 'wordpress-db.crhoi3wv0hh3.us-east-1.rds.amazonaws.com');/" /var/www/html/wordpress/wp-config.php
