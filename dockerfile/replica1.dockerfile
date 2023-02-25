FROM mysql:latest
COPY ./configfile/mysql-replica1-config.cnf /etc/mysql/conf.d

RUN chmod 777 /var/lib/mysql
RUN chmod 777 /var/lib/mysql-files