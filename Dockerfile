# Use the official PHP image as the base image
FROM php:8.1-apache

# Install required packages
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libicu-dev \
    g++ \
    zlib1g-dev \
    unzip \
    zip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd intl mysqli pdo pdo_mysql

# Enable Apache mods
RUN a2enmod rewrite

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set the working directory
WORKDIR /var/www/html

# Install Drupal (latest version)
RUN composer create-project drupal/recommended-project drupal

# Expose port 80
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
