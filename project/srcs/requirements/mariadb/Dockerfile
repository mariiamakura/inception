FROM alpine:3.19

#include env variable from .env
#if we want to use .env when container is running, we should us ENV
# but we only need env variale for creating container so we use ARG
ARG DB_NAME \
    DB_USER \
    DB_PASS
#every run create a new layer in imagem so it's better to use less runs
RUN apk update && apk add --no-cache mariadb mariadb-client
RUN mkdir /var/run/mysqld; \
    chmod 777 /var/run/mysqld; \
    {   echo '[mysqld]';\
        echo 'skip-host-cache';\
        echo 'skip-name-resolve';\
        echo 'bind-address=0.0.0.0'; \
    } | tee /etc/my.cnf.d/docker.cnf;\
    # 'tee' writes all echos to file and 'sed' changed line by values
    sed -i "s|skip-networking|skip-networking=0|g" \
        /etc/my.cnf.d/mariadb-server.cnf

#create mysql folder (contains settings) and grand access to user=mysql
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

EXPOSE 3306

# copy script to the container
COPY requirements/mariadb/conf/create_db.sh .
# run cript
RUN sh create_db.sh && rm create_db.sh
# run the container as if we were 'mysql' user
USER mysql
# default command to start from 
CMD ["/usr/bin/mysqld", "--skip-log-error"]
