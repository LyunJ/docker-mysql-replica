#!/bin/zsh
docker exec -i mysql-source-mysql-source-1 sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD"' < $1