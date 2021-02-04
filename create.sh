#!/bin/bash

########################################
# Help Commands

Help()
{
  echo "Usage : ./create.sh [OPTIONS]"
  echo "Example : ./create.sh /home/user/myproject blog"
  echo ""
  echo "Options :"
  echo "  -n, --name    The name of the new website you want to create."
  echo "  -p, --path    The path of the source folder that contains source files."
  echo "  -q, --quiet   Quiet mode. Nothing is written to standart output."
  echo "  -V, --version Print the script version"
}

########################################

Version()
{
  echo "Current version : 0.0.1"
}

PROJECT_NAME=""
PROJECT_PATH=""
IS_QUIET=0


for arg in "$@"
do
    case $arg in
        -n|--name)
        PROJECT_NAME="$2"
        shift
        ;;
        -p|--path)
        PROJECT_PATH="$2"
        shift
        ;;
        -q|--quiet)
        # Display nothing on the console
        shift
        ;;
        -h|--help)
        # display help
        Help
        exit
        ;;
        -V|--version)
        # display version
        Version
        exit
        ;;
    esac
done






SOURCE=$1
NAME=$2

HOSTS_PATH=""

#Detect if it is a WSL or a native linux
if grep -q Microsoft /proc/version; then
  HOSTS_PATH="/mnt/c/Windows/System32/drivers/etc/hosts"
else
  HOSTS_PATH="/etc/hosts"
fi

#Create symoblic link
ln -s $1 /var/www/$2

#touch /etc/apache2/sites-available/${NAME}.conf
# Write the new config file
cat >> /etc/apache2/sites-available/${NAME}.conf <<EOL
<VirtualHost *:80>
        ServerName www.${NAME}.local
        ServerAlias ${NAME}.local
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/${NAME}

        <Directory /var/www/>
               Options Indexes FollowSymLinks MultiViews
               AllowOverride all
               Order allow,deny
               Allow from all
        </Directory>

        ErrorLog /var/log/apache2/error.${NAME}.local.log
        CustomLog /var/log/apache2/error.${NAME}.local.log combined
</VirtualHost>
EOL

# Enable the new conf file
a2ensite ${NAME}.conf

#DNS
cat >> ${HOSTS_PATH} <<EOL
::1       www.${NAME}.local
127.0.0.1 www.${NAME}.local
::1       ${NAME}.local
127.0.0.1 ${NAME}.local
EOL

# Restart the apache's service
service apache2 restart

