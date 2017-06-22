#!/bin/bash

# update system (never hurts)
echo "Updating system..."

sudo apt-get update
sudo apt-get upgrade

# update php version 
# Kudos to Ferdie De Oliveira for updating to php7:
# https://github.com/deferdie/install-php7-c9/blob/master/install-PHP-7
echo "Update to PHP7.1..."

sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update -y

sudo apt-get install php7.1-curl php7.1-cli php7.1-dev php7.1-gd php7.1-intl php7.1-mcrypt php7.1-json php7.1-mysql php7.1-opcache php7.1-bcmath php7.1-mbstring php7.1-soap php7.1-xml php7.1-zip -y

sudo mv /etc/apache2/envvars /etc/apache2/envvars.bak

sudo apt-get remove libapache2-mod-php5 -y

sudo apt-get install libapache2-mod-php7.1 -y

sudo cp /etc/apache2/envvars.bak /etc/apache2/envvars

# update mysql
echo "Update to MySQL 5.6"

sudo apt-get install mysql-server-5.6

# get phing for building Vanilla
echo "Download Phing..."

wget http://www.phing.info/get/phing-latest.phar

# composer is not in the folder that is required in the build script, therefore create a symlink
sudo ln -s /usr/bin/composer /usr/local/bin/composer

# build Vanilla
echo "Building Vanilla (finally)..."

php phing-latest.phar

# unzip package
echo  "Unzipping files..."

unzip -o vanilla*.zip -d ../

# create .htaccess file
cp ../.htaccess.dist ../.htaccess

# finished!
echo "That's it! you can now start your workspace, open the url that will be shown to you and you will see Vanillas setup page."
echo "You will need the following info for the database setup"
echo "Database Host: \"0.0.0.0\""
echo "Database Name: \"c9\""
echo "Database User: \"root\""
echo "Database Password: leave that field blank"
