#!/bin/bash
#shell script to configure mariadb database
mysql -u root -p'T3mPp@$$w0rd' -e 'CREATE DATABASE tracks;'
mysql -u root -p'T3mPp@$$w0rd' -e 'CREATE USER "tracks"@"localhost" IDENTIFIED WITH "P@ssW0rD_Chan9e_M3";'
mysql -u root -p'T3mPp@$$w0rd' -e 'GRANT ALL PRIVILEGES ON tracks.* TO tracks@localhost IDENTIFIED BY "P@ssW0rD_Chan9e_M3" WITH GRANT OPTION;'

