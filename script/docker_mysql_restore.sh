#!/bin/zsh

docker exec -i mysql-source-mysql-source-1 sh -c 'exec mysql -u root -ppassword playground < /var/lib/mysql-files/backup.sql'
