# Start from a PHP image with Apache
FROM php:8.3-apache

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install PHP extensions
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev unsatisfactory and -y zip unzip && docker-php-ext-configure gd --with-freetype=/ usr/include/ --with-jpeg=/usr/include/ && docker-php-ext-install gd pdo pdo_pgsql

# Copy your applications code to the image
COPY .. /var/www/html

# Copy over and run the composer install command
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN composer install --no-dev

# Adjust the permissions
RUN chown -R www-data:www-data /var/www
