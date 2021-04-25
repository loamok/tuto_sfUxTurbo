#!/bin/bash

/bin/bash /var/www/make-pems.sh
/bin/bash /var/www/composer_migrate.sh
symfony console assets:install public --symlink --relative
symfony console fos:js-routing:dump --format=json --target=assets/js/fos_js_routes.json

/usr/local/sbin/php-fpm
