FROM php:8.2-apache

# Install and enable the mysqli extension required for MySQL connections
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

# Force PHP to output UTF-8 in HTTP headers globally for all pages
RUN echo "default_charset = 'UTF-8'" > /usr/local/etc/php/conf.d/charset.ini

