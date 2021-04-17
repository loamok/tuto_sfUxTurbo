#!/bin/bash

/bin/bash /var/www/composer_migrate.sh
symfony console assets:install public --symlink --relative

/usr/local/sbin/php-fpm
