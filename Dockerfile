FROM debian:10

MAINTAINER corozco <corozco@student.42.fr>

ADD /srcs/db.sql /tmp/
#ADD /srcs/wordpress.sql /tmp/

RUN apt-get update \
	&& apt-get -y upgrade \
	&& apt-get install -y \
		wget \
		nginx \
		mariadb-server \
		unzip \
		nano \
	&& wget https://wordpress.org/latest.zip

#Installing Additional PHP Extensions
RUN apt-get install -y \
	php-mysql \
	php-fpm \
	php-mysql \
	php-cli

RUN mkdir -p /var/www/html /var/www/info\
	&& unzip latest.zip -d /var/www/ \
	&& chown -R $USER:$USER /var/www/* \
	&& chown -R www-data:www-data /var/www/* \
	&& chmod -R 755 /var/www/* \
	&& service mysql start \
	&& mysql -u root --password= < /tmp/db.sql

ADD /srcs/localhost /etc/nginx/sites-available/localhost
ADD /srcs/info.php /var/www/info/info.php
ADD /srcs/wp-config.php /var/www/wordpress/wp-config.php
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/
# Port 80 ouvert
EXPOSE 80

EXPOSE 22

CMD service nginx restart && service mysql restart && service php7.3-fpm start && bash

