# Start from a PHP image with Apache
FROM php:8.3-apache

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install PHP extensions and other dependencies
RUN apt-get update -y && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zlib1g-dev \
    libpq-dev \
    zip \
    unzip

# Configure and install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_pgsql

# Copy your application's code to the image
COPY . /var/www/html

# Adjust permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/storage

# Expose port 80 and start Apache
EXPOSE 80
CMD ["apache2-foreground"]

