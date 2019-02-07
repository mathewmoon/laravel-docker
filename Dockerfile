FROM alpine:3.9

RUN apk add --no-cache php7-fpm \
    php7-cli \
    bash \
    nginx \
    php7-tokenizer \
    php7-openssl \
    php7-pdo \
    php7-mbstring \
    php7-json \
    php7-ctype \
    php7-xml \
    php7-zip \
    php7-dom \
    php7-xmlwriter \
    php7-session \
    composer && \
    adduser -D -g 'www' www -h /www && \
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /www && \
    echo 'include=/etc/php7/conf.d/*.ini' >>/etc/php7/php.ini

COPY nginx.conf /etc/nginx/nginx.conf
COPY docker_entry.sh /docker_entry.sh

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    ln -sf /dev/stderr /var/log/php7/error.log  && \
    chmod +x /docker_entry.sh

WORKDIR /www

RUN su www -s /bin/bash -c "mkdir /www/project"
RUN su www -s /bin/bash -c "composer global require laravel/installer"
RUN su www -s /bin/bash -c "composer create-project --prefer-dist laravel/laravel /www/project"

CMD ["/docker_entry.sh"]
     
