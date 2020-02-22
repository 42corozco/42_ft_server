#!/bin/bash

case $1 in
	"on")
		sed -i 's/autoindex off/autoindex on/' /etc/nginx/sites-enabled/localhost
		service nginx restart
		;;
	"off")
		sed -i 's/autoindex on/autoindex off/' /etc/nginx/sites-enabled/localhost
		service nginx restart
		;;
	*)
		echo "Sorry"
		;;
esac
