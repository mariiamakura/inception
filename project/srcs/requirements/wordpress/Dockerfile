FROM alpine:3.19
ARG PHP_VERSION=82 \
    DB_NAME \
    DB_USER \
    DB_PASS
RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-exif \
    php${PHP_VERSION}-fileinfo \
    #php${PHP_VERSION}-hash \
    #php${PHP_VERSION}-igbinary \
    #php${PHP_VERSION}-imagick \
    php${PHP_VERSION}-intl \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-openssl \
    #php${PHP_VERSION}-pcre \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-redis \
    wget \
    unzip && \
    #change so wordpress listen to all connections on 9000 port
    sed -i "s|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|g" \
    /etc/php82/php-fpm.d/www.conf && \
    #uncomment the line so the owner is non-privileged  
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
    /etc/php82/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
    /etc/php82/php-fpm.d/www.conf && \
    #remove cache
    rm -f /var/cache/apk/*
#set working dir as :
WORKDIR /var/www
#download latest wordpress. copy to work dir and install
RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip
COPY ./requirements/wordpress/conf/wp-config-create.sh .
RUN sh wp-config-create.sh && rm wp-config-create.sh && \
    chmod -R 0777 wp-content 
CMD ["/usr/sbin/php-fpm82", "-F"]
