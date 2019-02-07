#!/bin/sh

export PHP_FPM_USER="www" PHP_FPM_GROUP="www" PHP_DISPLAY_ERRORS="On"
php-fpm7 -O -D -c /etc/php7/php.ini
nginx -g "daemon off;"
