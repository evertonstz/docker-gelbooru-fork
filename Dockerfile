FROM linuxconfig/lamp

#TODO: make backups for the configs messing with them, 
	#also the end user will have acess to the original files in case it's needed

#copy gelbooru
COPY gelbooru-fork/ /var/www/html/

#changes on gelbooruconfig files#
RUN sed -i 's/$mysql_host =.*/$mysql_host = "localhost";/' /var/www/html/config.php
RUN sed -i 's/$mysql_user =.*/$mysql_user = "gelbooru";/' /var/www/html/config.php
RUN sed -i 's/$mysql_pass =.*/$mysql_pass = "gelbooru";/' /var/www/html/config.php
RUN sed -i 's/$mysql_db =.*/$mysql_db = "gelbooru1";/' /var/www/html/config.php
RUN sed -i 's/$site_url =.*/$site_url = "";/' /var/www/html/config.php
RUN sed -i 's:$thumbnail_url =.*:$thumbnail_url = "/thumbnails/";:g' /var/www/html/config.php

#changes on apache2 config file#
RUN sed -i 's:DocumentRoot.*:ServerRoot /var/www/html/:g' /etc/apache2/sites-enabled/000-default.conf

#update, install dependencies and clean after
RUN apt update
RUN apt install -y php-mbstring
RUN apt clean

#removing default index.html created by apache2
RUN rm /var/www/html/index.html

#uncoment necessary configuration lines on php's config file
RUN sed -i '/;extension=php_pdo_mysql.dll/s/^;//g' /etc/php/7.0/apache2/php.ini
RUN sed -i '/;extension=php_mysqli.dll/s/^;//g' /etc/php/7.0/apache2/php.ini
RUN sed -i '/;extension=php_mbstring.dll/s/^;//g' /etc/php/7.0/apache2/php.ini
RUN sed -i '/;extension=php_gd2.dll/s/^;//g' /etc/php/7.0/apache2/php.ini
RUN sed -i 's/;gd.jpeg_ignore_warning =.*/gd.jpeg_ignore_warning = 1/' /etc/php/7.0/apache2/php.ini

#change permissions as required by gelbooru (info on their readme)
RUN chmod 777 /var/www/html/images/
RUN chmod 777 /var/www/html/thumbnails/
RUN chmod 777 /var/www/html/tmp/

#exposing ports (might not expose 443 in the future?)
EXPOSE 80 443

#echo
RUN echo "please, go to http://localhost:port/install/index.php to register the admin account for gelbooru!"
RUN echo "Admin tools are available at http://localhost:port/admin/index.php"