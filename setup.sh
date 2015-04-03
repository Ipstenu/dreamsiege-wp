#!/bin/bash

####################################################################
# SETUP.SH - WordPress Plugin Script for Siege Testing             #
#                                                                  #
# This script assumes that you have wp-cli active and are running  #
# as an authorized user. Don't run as root!                        #
#                                                                  #
# Author: Mika Epstein                                             #
# URL: https://github.com/Ipstenu/dreamsiege-wp                    #
# License: GPLv2                                                   #
#                                                                  #
# Usage: ./setup.sh                                                #
#                                                                  #
# ACTION == install or update: Will either run full install or     #
#           update the install                                     #
# TARGET == basic, inter, advan: Will target that environment. If  #
#           empty, assumes all.                                    #
####################################################################

# This is the install procedure
function installwp() {		
	# Check if the folder exists, if not we need to make it (it SHOULD if you downloaded the repo, but ...)
	if [ ! -d $1 ]
	then
		mkdir $1
	fi

	if ! $(wp core is-installed --path=$1); 
		then
		echo "Installing WordPress for the $1 test..."
		wp core download --path=$1 --quiet
		
		# Collect information for wp-config
		read -p "Database Name [default: wordpress]: " database
		database=${database:-wordpress}
		read -p "Database User [default: wp]: " dbuser
		dbuser=${dbuser:-wp}
		read -p "Database User Password [default: wp]: " dbpass
		dbpass=${dbpass:-wp}
		read -p "Database Hostname [default: localhost]: " dbhost
		dbhost=${dbhost:-localhost}

		# Create wp-config
		wp core config  --path=$1 --dbname="$database" --dbprefix=wp_$1_ --dbuser=$dbuser --dbpass=$dbpass --dbhost=$dbhost --extra-php < configs/wp-constants
		
		# Collect information for WordPress
		read -p "Your Domain [default: http://example.com/$1]: " domain
		domain=${domain:-http://example.com/$1}

		# Actually install WordPress
		wp core install --path=$1 --url=$domain --title="Siege Testing - $1" --admin_user=admin --admin_password=password --admin_email=admin@example.com
		
		# Import DB
		wp db import --path=$1 configs/wordpress-$1.sql

		# Search-Replace
		wp search-replace "http://dreamhost.dev/dreamsiege-wp/$1" $domain

	fi
}

# This is the install procedure
function updatewp() {
	wp core update --path=$1
	wp core update-db --path=$1
	wp plugin update --all --path=$1 
	wp theme update --all --path=$1
}

# This is the actual script

read -p "What do you want to do? [install|update] " action
action=${action:-install}

echo "Awesome! We're going to $action WordPress."

read -p "What sites do you want to $action? [basic|inter|advan|all] " target
target=${target:-all}

if [ "$target" = "all" ] 
then
	target_array=(basic inter advan)
else
    target_array=($target)
fi

for i in "${target_array[@]}"
	do
		if [ "$action" = "install" ]
		then
			installwp $i
			updatewp $i
		elif [ "$action" = "update" ]
		then
		    echo "Updating $i ..."
			updatewp $i
		else
			echo "You shouldn't be able to get here but you did."
		fi
	done