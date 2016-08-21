#!/bin/bash
#shell script to configure mariadb database
#setup mysql root password
service mysql start
mysqladmin -u root password 'T3mPp@$$w0rd'
#mysql -u root -e ''
service mysql restart
mysql -u root -p'T3mPp@$$w0rd' -e 'CREATE DATABASE tracks;'
mysql -u root -p'T3mPp@$$w0rd' -e 'CREATE USER "tracks"@"localhost" IDENTIFIED WITH "P@ssW0rD_Chan9e_M3";'
mysql -u root -p'T3mPp@$$w0rd' -e 'GRANT ALL PRIVILEGES ON tracks.* TO tracks@localhost IDENTIFIED BY "P@ssW0rD_Chan9e_M3" WITH GRANT OPTION;'
#fixing nginx default
mv /etc/nginx/sites-enabled/default /etc/nginx/sites-enabled/default.orig
mv /tmp/default /etc/nginx/sites-enabled/default
rm -f /tmp/tracks_db.sh

