docker-php-base
===============
[![Build Status](https://travis-ci.org/jeboehm/docker-php-base.svg?branch=7.2)](https://travis-ci.org/jeboehm/docker-php-nginx-base)

This provides a ready to use PHP image, which has some commonly used modules.

Developing using this image
---------------------------
To develop applications using this image, delete the file `/usr/local/etc/php/conf.d/production.ini` in DEV mode. If you need,
you can enable xdebug by running ```docker-php-ext-enable xdebug```.
