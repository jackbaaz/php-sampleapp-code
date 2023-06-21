# Use an official PHP runtime as the base image
FROM php:7.4-apache

# Set the working directory in the container
WORKDIR /var/www/html

# Copy the application code to the container
COPY . /var/www/html

# Install PHP extensions and other dependencies
RUN apt-get update && \
    apt-get install -y \
        libpng-dev \
        libjpeg-dev \
        libpq-dev \
        && \
    docker-php-ext-configure gd --with-jpeg && \
    docker-php-ext-install -j$(nproc) \
        gd \
        pdo \
        pdo_mysql \
        pdo_pgsql \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Enable Apache rewrite module
RUN a2enmod rewrite

# Expose the port that Apache is listening on
EXPOSE 80

# Start Apache service when the container launches
CMD ["apache2-foreground"]
