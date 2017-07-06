FROM ubuntu:16.04

# Labels
LABEL maintainer "oscar.fanelli@gmail.com"

# Environment variables
ENV PROJECT_PATH=/var/www \
    DEBIAN_FRONTEND=noninteractive \
    PHP_INI=/etc/php/5.6/cli/php.ini \
    TERM=xterm

# First update and upgrade
RUN apt update -q && apt upgrade -yqq && apt install -yqq curl software-properties-common locales

# Locale generator
RUN locale-gen en_US.UTF-8

# Langs
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Use PHP5.6 instead of PHP7
RUN add-apt-repository ppa:ondrej/php
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C

# PHP and supplementary programs
RUN apt update -q && apt install -yqq --force-yes \
    git \
    wget \
    zip \
    php5.6 \
    php5.6-dom \
    php5.6-curl \
    php5.6-mbstring \
    php5.6-mysql \
    php5.6-mongo

# Explicit tell to use PHP5.6
RUN update-alternatives --set php /usr/bin/php5.6

# Cleanup
RUN apt purge -yq \
      wget \
      patch \
      software-properties-common && \
    apt autoremove -yqq

# php.ini configs
RUN sed -i "s/short_open_tag = .*/short_open_tag = On/" $PHP_INI && \
    sed -i "s/memory_limit = .*/memory_limit = 256M/" $PHP_INI && \
    sed -i "s/display_errors = .*/display_errors = Off/" $PHP_INI && \
    sed -i "s/display_startup_errors = .*/display_startup_errors = Off/" $PHP_INI && \
    sed -i "s/post_max_size = .*/post_max_size = 64M/" $PHP_INI && \
    sed -i "s/upload_max_filesize = .*/upload_max_filesize = 32M/" $PHP_INI && \
    sed -i "s/max_file_uploads = .*/max_file_uploads = 10/" $PHP_INI && \
    sed -i "s/error_reporting = .*/error_reporting = E_ALL \& ~E_DEPRECATED \& ~E_STRICT/" $PHP_INI

# Change workdir
WORKDIR $PROJECT_PATH

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Start php with interactive shell
CMD ["php", "-a"]