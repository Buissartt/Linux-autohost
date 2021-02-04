#!/bin/bash


exec 6>&1 # Save default stdout to position 6

########################################
# Help Commands

Help()
{
	RestoreStdOut
	echo "Usage : ./create [OPTIONS]"
	echo "Example : ./create -p=/home/user/myproject -n=blog"
	echo ""
	echo "Options :"
	echo "  -n, --name    (Required) The name of the new website you want to create."
	echo "  -p, --path    (Required) The path of the source folder that contains source files."
	echo "  -q, --quiet   (Optional) Quiet mode. Nothing is written to standart output."
	echo "  -V, --version (Optional) Print the script version."
	echo "  -h, --help    (Optional) Print the help message."
}

########################################


Version()
{
	RestoreStdOut
  	echo -e "\e[32mCurrent version : 0.0.1\e[39m"
}

Main()
{

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
}

Verif()
{
	RestoreStdOut

	if [[ -z $PROJECT_NAME || -z $PROJECT_PATH ]]; then
		echo -e "\e[31mError \e[39m: Invalid arguments. You need to specify both project name and project path."
		echo -e "For more informations, type \e[33m./create.sh -h\e[39m"
		exit
	fi

	
	# add file exists verification

}

QuietStdOut()
{
	exec > /dev/null # overwrite default stdout to /dev/null
}

RestoreStdOut()
{
	exec 1>&6 # restore default stdout
}


PROJECT_NAME=""
PROJECT_PATH=""
IS_QUIET=0


for arg in "$@"
do
	case $arg in
		-n=*|--name=*)
			PROJECT_NAME="${arg#*=}"
			shift
			shift
		;;
		-p=*|--path=*)
			PROJECT_PATH="${arg#*=}"
			shift
			shift
		;;
		-q|--quiet) # Display nothing on the console
			QuietStdOut
			shift
		;;
		-h|--help) # display help
			Help
			exit
		;;
		-V|--version) # display version
			Version
			exit
		;;
	esac
done

Verif
Main
RestoreStdOut
exit
