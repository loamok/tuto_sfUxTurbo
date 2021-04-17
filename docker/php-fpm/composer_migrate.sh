#!/bin/bash

cd /var/www/sfuxturbo

/usr/local/bin/symfony composer install -n
/usr/local/bin/symfony console doctrine:migrations:migrate --allow-no-migration --no-interaction
