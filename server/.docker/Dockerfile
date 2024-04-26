FROM php:apache

EXPOSE 80

# apt-get
RUN apt-get update && \
    apt-get -y install \
        curl \
        zip \
        unzip \
        libzip-dev \
        libpq-dev \
        postgresql-client

# docker-php ext-install:
RUN docker-php-ext-install zip \
    pdo_pgsql

# composer:
COPY .docker/composer-install.sh /tmp
RUN /tmp/composer-install.sh && mv composer.phar /usr/local/bin/composer

# DIR
WORKDIR /server
COPY . ./

# apache:
COPY .docker/vhost.conf /etc/apache2/sites-available/000-default.conf

# composer configuration:
COPY ./composer.json ./composer.json
COPY ./composer.lock ./composer.lock

RUN composer install --no-interaction --no-scripts

# entrypoint
COPY .docker/Entrypoint.sh /usr/local/bin/

# www-data:
RUN chown -R www-data:www-data ./ && a2enmod rewrite
RUN chown -R www-data:www-data ./storage

RUN chmod 755 /usr/local/bin/Entrypoint.sh
