#RUN mysql -u root -e "CREATE USER 'gelbooru'@'localhost' IDENTIFIED BY 'gelbooru';"
#RUN mysql -u root -e "GRANT ALL PRIVILEGES ON * . * TO 'gelbooru'@'localhost';"
#RUN mysql -u gelbooru -p"gelbooru" -e "create database gelbooru1"
