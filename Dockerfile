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

RUN mkdir -p /var/www/localhost/html \
	&& unzip latest.zip -d /var/www/localhost/ \
	&& mv /var/www/localhost/wordpress/* /var/www/localhost/html \
	&& chown -R $USER:$USER /var/www/localhost/* \
	&& chown -R www-data:www-data /var/www/* \
	&& chmod -R 755 /var/www/* \
	&& service mysql start \
	&& mysql -u root --password= < /tmp/db.sql

ADD /srcs/index.html /var/www/localhost/html/index.html
ADD /srcs/localhost /etc/nginx/sites-available/localhost
ADD /srcs/info.php /var/www/localhost/html/info.php
ADD /srcs/wp-config.php /var/www/localhost/html/wp-config.php
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/
# Port 80 ouvert
EXPOSE 80

EXPOSE 22

CMD service nginx restart && service mysql restart && service php7.3-fpm start && bash

