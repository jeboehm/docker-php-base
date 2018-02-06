#!/bin/sh
set -e

cd /var/www/html
composer install
composer test
