FROM mysql:latest
COPY ./configfile/mysql-source-config.cnf /etc/mysql/conf.d

RUN chmod 777 /var/lib/mysql
RUN chmod 777 /var/lib/mysql-files