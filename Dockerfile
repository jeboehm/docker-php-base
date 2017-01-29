FROM php:7.1-fpm-alpine
MAINTAINER Jeffrey Boehm "jeff@ressourcenkonflikt.de"

ENV \
    PHP_REDIS_VERSION=3.1.0 \
    PHP_APCU_VERSION=5.1.8

RUN apk add --no-cache \
      freetype \
      libpng \
      libjpeg-turbo \
      freetype-dev \
      libmcrypt-dev \
      libpng-dev \
      libjpeg-turbo-dev \
      wget \
      ca-certificates && \
    apk add --no-cache --virtual build-deps \
      coreutils \
      build-base \
      autoconf \
      automake && \
    docker-php-ext-configure gd \
      --with-gd \
      --with-freetype-dir=/usr/include/ \
      --with-png-dir=/usr/include/ \
      --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) \
      bcmath \
      gd \
      opcache \
      mcrypt \
      mysqli \
      pdo_mysql \
      zip && \
    pecl install \
      apcu-${PHP_APCU_VERSION} \
      redis-${PHP_REDIS_VERSION} && \
    docker-php-ext-enable \
      apcu \
      redis && \
    rm -rf /tmp/pear && \
    apk del build-deps && \
    update-ca-certificates && \
    ln -s /usr/local/bin/php /usr/bin/php

COPY rootfs/ /

CMD ["--help"]
ENTRYPOINT ["/usr/local/bin/php"]
