#!/bin/bash

echo "===============MYSQL REPLICA INIT START=================="

docker exec -i mysql-source-mysql-source-1 mysql -h 172.18.0.2 --protocol=tcp -u root -ppassword -D playground < ./schema/db_playground/create_replica_user.sql
docker exec -i mysql-source-mysql-replica1-1 mysql -h 172.18.0.5 --protocol=tcp -u root -ppassword -D playground < ./schema/db_playground/start_replication.sql
docker exec -i mysql-source-mysql-replica2-1 mysql -h 172.18.0.4 --protocol=tcp -u root -ppassword -D playground < ./schema/db_playground/start_replication.sql
docker exec -i mysql-source-mysql-replica3-1 mysql -h 172.18.0.3 --protocol=tcp -u root -ppassword -D playground < ./schema/db_playground/start_replication.sql