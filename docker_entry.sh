#!/bin/sh

export PHP_FPM_USER="www" PHP_FPM_GROUP="www" PHP_DISPLAY_ERRORS="On"

[ -z ${PHP_PORT} ] && PHP_PORT=9000

#If you are running php by itself then you probably want to bind to all addresses so your frontend can connect
[ ! -z ${PHP_BIND_ALL} ]; then
  sed -ri "s/^listen\s=\s.*/listen = 0.0.0.0:${PHP_PORT}/g" /etc/php7/php-fpm.d/www.conf
fi

if [ -z ${SERVICE} ]; then
  php-fpm && php-fpm7 -O -D -c /etc/php7/php.ini
  nginx && nginx -g "daemon off;"
else
 [ ${SERVICE} = nginx ] && nginx && nginx -g "daemon off;"
 [ ${SERVICE} = php-fpm ] && php-fpm && php-fpm7 -O -F -c /etc/php7/php.ini
fi
