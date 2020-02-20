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
		nano

#Installing Additional PHP Extensions
RUN apt-get install -y \
	php-mysql \
	php-fpm \
	php-mysql \
	php-cli

RUN mkdir -p /var/www/localhost/html \
	&& chown -R $USER:$USER /var/www/localhost/html \
	&& chmod -R 755 /var/www/localhost

ADD /srcs/index.html /var/www/localhost/html/index.html
ADD /srcs/localhost /etc/nginx/sites-available/localhost
ADD /srcs/info.php /var/www/localhost/html/info.php
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/
# Port 80 ouvert
EXPOSE 80

EXPOSE 22

#para ejecutarlo al infinito
CMD service nginx restart && service mysql start && service php7.3-fpm start && bash
#CMD service nginx restart && tail -f /dev/null
