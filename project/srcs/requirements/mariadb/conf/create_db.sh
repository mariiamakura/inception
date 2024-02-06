#!bin/sh

#if mysql (settings folder for mariadb) is not installed
if [ ! -d "/var/lib/mysql/mysql" ]; then
    #set owenership of the folder to user and group
    chown -R mysql:mysql /var/lib/mysql

    #init mariadb settings, --rmp install mode for linux based systems
    mysql_install_db --basedir=/usr --datadir=var/lib/mysql --user=mysql --rpm
fi 

# check if wordpress database exist in "mysql"  folder and if not write to the create_db.sql
if [ ! -d "/var/lib/mysql/wordpress" ]; then
    cat << EOF > /tmp/create_db.sql

#select "mysql" database system settings
USE mysql;
FLUSH PRIVILEGES;
#delete empty users in mysql
DELETE FROM     mysql.user WHERE User='';
#delete preinstalled database "test"
DROP DATABASE test;
#delete any references to "test"
DELETE FROM mysql.db WHERE Db='test';
#only allowed connection as 'root' for local host
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
#change root password to DB_ROOT
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT}';
#create wordpress database
CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
#create wordpress user 
CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_PASS}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_USER}'@'%';
#reload privilages
FLUSH PRIVILEGES;
EOF
     # run reate_db.sql and delete it
        /usr/bin/mysqld --user=mysql --bootstrap < /tmp/create_db.sql
        rm -f /tmp/create_db.sql
fi
