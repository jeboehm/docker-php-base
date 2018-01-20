ARG PHP_VER=7.1
ARG COMPOSER_VER=1.6.2

FROM composer:${COMPOSER_VER}

FROM php:${PHP_VER}-fpm-alpine

LABEL maintainer="jeff@ressourcenkonflikt.de"
ENV COMPOSER_ALLOW_SUPERUSER=1

RUN apk add --no-cache \
      ca-certificates \
      curl \
      freetype \
      freetype-dev \
      git \
      icu-dev \
      libjpeg-turbo \
      libjpeg-turbo-dev \
      libmcrypt-dev \
      libpng \
      libpng-dev \
      make \
      mysql-client \
      pcre-dev \
      unzip \
      wget && \
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
      intl \
      mcrypt \
      mysqli \
      opcache \
      pdo_mysql \
      zip && \
    pecl install \
      apcu \
      redis \
      xdebug && \
    docker-php-ext-enable \
      apcu \
      redis && \
    rm -rf /tmp/pear && \
    apk del build-deps && \
    update-ca-certificates && \
    ln -s /usr/local/bin/php /usr/bin/php

# Note that xdebug is installed but disabled by default.
# RUN docker-php-ext-enable xdebug

COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY rootfs/ /
