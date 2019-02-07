#!/bin/sh

export PHP_FPM_USER="www" PHP_FPM_GROUP="www" PHP_DISPLAY_ERRORS="On"

if [ -z ${SERVICE} ]; then
  php-fpm && php-fpm7 -O -D -c /etc/php7/php.ini
  nginx && nginx -g "daemon off;"
else
 [ ${SERVICE} = nginx ] && nginx && nginx -g "daemon off;"
 [ ${SERVICE} = php-fpm ] && php-fpm && php-fpm7 -O -F -c /etc/php7/php.ini
fi
