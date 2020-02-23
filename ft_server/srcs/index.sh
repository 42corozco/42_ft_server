#!/bin/bash

case $1 in
	"on")
		echo -e "\e[32mAutoindex is actived\e[39m"
		sed -i 's/autoindex off/autoindex on/' /etc/nginx/sites-enabled/localhost
		service nginx restart
		echo  ""
		;;
	"off")
		echo -e "\e[31mAutoindex is inactivated\e[39m"
		sed -i 's/autoindex on/autoindex off/' /etc/nginx/sites-enabled/localhost
		service nginx restart
		echo ""
		;;
	*)
		echo -e "\e[31mError this value does not exist in the index"
		echo -n -e "\e[32mautoindex is : "
		echo | grep '\(autoindex on\|autoindex off\)' /etc/nginx/sites-enabled/localhost | cut -c13-
		echo -e "\e[39m"
		;;
esac
