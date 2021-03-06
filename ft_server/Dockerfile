FROM debian:10

MAINTAINER corozco <corozco@student.42.fr>

ADD /srcs/db.sql /tmp/

RUN apt-get update \
	&& apt-get -y upgrade \
	&& apt-get install -y \
		wget \
		nginx \
		mariadb-server \
		unzip \
	&& wget https://wordpress.org/latest.zip \
	&& wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz

RUN apt-get install -y \
	php-mysql \
	php-fpm \
	php-cli

RUN mkdir -p /var/www/html /var/www/info\
	&& unzip latest.zip -d /var/www/ \
	&& tar xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz \
	&& mv phpMyAdmin-4.9.0.1-all-languages /var/www/phpmyadmin \
	&& rm latest.zip phpMyAdmin-4.9.0.1-all-languages.tar.gz \
	&& chown -R $USER:$USER /var/www/* \
	&& chown -R www-data:www-data /var/www/* \
	&& chmod -R 755 /var/www/* \
	&& service mysql start \
	&& mysql -u root --password= < /tmp/db.sql \
	&& yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

ADD /srcs/localhost /etc/nginx/sites-available/localhost
ADD /srcs/info.php /var/www/info/info.php
ADD /srcs/wp-config.php /var/www/wordpress/wp-config.php
ADD /srcs/config.inc.php /var/www/phpmyadmin/config.inc.php
ADD /srcs/index.sh /tmp/index.sh
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/ \
	&& echo "alias index='bash /tmp/index.sh'" >> /root/.bashrc

EXPOSE 80
EXPOSE 443

CMD service nginx restart \
	&& service mysql start \
	&& service php7.3-fpm start \
	&& bash /tmp/index.sh $index \
	&& bash
