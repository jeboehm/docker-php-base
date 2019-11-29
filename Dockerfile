ARG PHP_VER=7.4
ARG COMPOSER_VER=1.9.1

FROM composer:${COMPOSER_VER}

FROM php:${PHP_VER}-fpm-alpine

LABEL maintainer="jeff@ressourcenkonflikt.de"
ENV COMPOSER_ALLOW_SUPERUSER=1 \
    LD_PRELOAD=/usr/lib/preloadable_libiconv.so

RUN apk add --no-cache \
      ca-certificates \
      curl \
      freetype \
      git \
      gnu-libiconv \
      icu \
      imagemagick \
      libjpeg-turbo \
      libpng \
      libzip \
      make \
      mysql-client \
      pcre \
      tzdata \
      unzip \
      wget && \
    apk add --no-cache --virtual build-deps \
      autoconf \
      automake \
      build-base \
      coreutils \
      freetype-dev \
      icu-dev \
      imagemagick-dev \
      libtool \
      libjpeg-turbo-dev \
      libpng-dev \
      libzip-dev \
      pcre-dev && \
    docker-php-ext-install -j$(nproc) \
      bcmath \
      gd \
      intl \
      mysqli \
      opcache \
      pdo_mysql \
      zip && \
    pecl install \
      apcu \
      imagick \
      redis \
      xdebug && \
    docker-php-ext-enable \
      apcu \
      imagick \
      redis && \
    rm -rf /tmp/pear && \
    apk del build-deps && \
    update-ca-certificates && \
    ln -s /usr/local/bin/php /usr/bin/php

# Note that xdebug is installed but disabled by default.
# RUN docker-php-ext-enable xdebug

COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY rootfs/ /
