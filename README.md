# docker-gelbooru-fork

The easiest way to deploy a container with Gelbooru-fork! Now you can privately host all your prictures using all the power of the boorus: tag support, user support, made for huge libraries. DON'T USE THIS CONTAINER FOR PUBLICLY HOSTING BOORUS UNLESS YOU KNOW WHAT YOU'RE DOING, AS I CAN'T GUARANTEE SECURITY!

## Fastest way to deploy

```
docker run -p 44555:80 --name=gelbooru -dP evertonstz/docker-gelbooru-fork
```

Runing the command above will deploy a container with the name "gelbooru". It's not yet ready to use, you'll need to set some user preferences on MySQL manually:

Enter your container's bash:
```
docker exec -it lamp /bin/bash
```
Make a mysql user called "gelbooru" with password "gelbooru": *
```
mysql -u root -e "CREATE USER 'gelbooru'@'localhost' IDENTIFIED BY 'gelbooru';"
```
Give necessary permissions to the new user:
```
mysql -u root -e "GRANT ALL PRIVILEGES ON * . * TO 'gelbooru'@'localhost';"
```
Creteate the database "gelbooru1" with the user "gelbooru":
```
mysql -u gelbooru -p"gelbooru" -e "create database gelbooru1"
```
Use "exit" to close the container's bash shell.

After that you'll need to go to the following link and signu with your ADMINISTRATOR info in your web browser: http://localhost:44555/install/index.php

Wait for the message, and go to Gelbooru main page to test things: http://localhost:44555
You should now be able to whatever you want inside gelbooru, in my tests the first image that you upload will have a broken thumbnail, but for the rest of the images it'll work fine.

The administrator(s) page is located at: http://localhost:44555/admin/index.php

*in case you decide to change the credentials, you'll need to also change the gelbooru config file to match, the file is located at /var/www/html/config.php


## Paths inside the container you might want to know:

You'll probably need to backup you images and database from time to time, the method is with you (I mounth them locally and backup using a software called borg :> ):
images files:
```
/var/www/html/images
```
mysql database files:
```
/var/lib/mysql
```

Those you'll only need a backup if made any customization, if your installation is default backingup these is redundant, as the Dockerfile can regenerate tem:
apache2 config file:
```
/etc/apache2/sites-enabled/000-default.conf
```
gelbooru config file:
```
/var/www/html/config.php
```
php config file:
```
/etc/php/7.0/apache2/php.ini
```
