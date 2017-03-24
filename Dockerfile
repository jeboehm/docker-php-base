FROM php:7.1-fpm-alpine
MAINTAINER Jeffrey Boehm "jeff@ressourcenkonflikt.de"

RUN apk add --no-cache \
      ca-certificates \
      freetype \
      freetype-dev \
      git \
      icu-dev \
      libjpeg-turbo \
      libjpeg-turbo-dev \
      libmcrypt-dev \
      libpng \
      libpng-dev \
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
      redis && \
    docker-php-ext-enable \
      apcu \
      redis && \
    rm -rf /tmp/pear && \
    apk del build-deps && \
    update-ca-certificates && \
    ln -s /usr/local/bin/php /usr/bin/php && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY rootfs/ /
