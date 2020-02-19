FROM debian:10

MAINTAINER corozco <corozco@student.42.fr>

RUN apt-get update \
	&& apt-get -y upgrade \
	&& apt-get install -y \
		wget \
		nginx \
		nano

#Installing Additional PHP Extensions
#RUN apt-get install -y \
#		php-fpm
#		php-curl \
#		php-gd \
#		php-intl \
#		php-mbstring \
#		php-soap \
#		php-xml \
#		php-xmlrpc \
#		php-zip

RUN mkdir -p /var/www/localhost/html \
	&& chown -R $USER:$USER /var/www/localhost/html \
	&& chmod -R 755 /var/www/localhost

ADD /srcs/index.html /var/www/localhost/html/index.html
ADD /srcs/localhost /etc/nginx/sites-available/localhost
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/
# Port 80 ouvert
EXPOSE 80

EXPOSE 22

#para ejecutarlo al infinito
CMD service nginx restart && bash
#CMD service nginx restart && tail -f /dev/null
