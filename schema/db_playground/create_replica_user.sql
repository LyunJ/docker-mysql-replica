CREATE USER 'repl_user'@'172.18.0.3' IDENTIFIED BY 'password';
GRANT REPLICATION SLAVE ON *.* TO 'repl_user'@'172.18.0.3';
CREATE USER 'repl_user'@'172.18.0.4' IDENTIFIED BY 'password';
GRANT REPLICATION SLAVE ON *.* TO 'repl_user'@'172.18.0.4';
CREATE USER 'repl_user'@'172.18.0.5' IDENTIFIED BY 'password';
GRANT REPLICATION SLAVE ON *.* TO 'repl_user'@'172.18.0.5';