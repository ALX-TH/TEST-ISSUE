FROM php:7.1.9-fpm

# Prevent error in terminal
ENV TERM="xterm-256color"

# Installing dependencies
RUN apt-get update && apt-get install -y \
    build-essential automake libtool \
    git \
    locales \
    zip gnupg \
    gifsicle \
    zlib1g-dev \
    mysql-client

# Installing extensions
RUN docker-php-ext-install pdo_mysql zip exif pcntl

# Clear cache
RUN apt-get autoremove -y && apt-get clean all
RUN rm -rf /var/lib/apt/lists/*

# Copy config file
ADD php.ini /usr/local/etc/php/conf.d/custom.ini

# Allow container to write on host
RUN usermod -u 1000 www-data

WORKDIR /usr/app
VOLUME /usr/app

EXPOSE 9000
CMD ["php", "-S", "0.0.0.0:9000", "-t", "./web", "./web/index.php"]
