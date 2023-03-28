#!/bin/zsh

docker exec -i mysql-source-mysql-source-1 sh -c 'exec mysqldump -u root -ppassword playground --set-gtid-purged=OFF > /var/lib/mysql-files/backup.sql'