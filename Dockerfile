FROM php:8.0-fpm-alpine
LABEL author="plump_albert"

# Download script for easy extension installation
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/bin/

# Install php extensions
RUN chmod +x /usr/bin/install-php-extensions \
	&& install-php-extensions	pdo_pgsql \
								bcmath

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
	&& php composer-setup.php \
	&& php -r "unlink('composer-setup.php');" \
	&& mv composer.phar /usr/bin/composer

# Copy php config files
ADD php.ini /etc/php8/conf.d/10-custom.ini
ADD php-fpm.conf /etc/php8/php-fpm.conf

# Copy application to docker
RUN adduser -DHg www www
COPY --chown=www:www www/ /var/www
ADD  --chown=www:www .env /var/www
WORKDIR /var/www
RUN sed -ie "s/#HOST#/$APP_URL/g" resources/views/index.php

# Install composer dependecies
RUN composer install \
	--no-ansi \
	--no-dev \
	--no-interaction \
	--no-plugins \
	--no-progress \
	--no-scripts \
	--optimize-autoloader

# Generate application key
RUN php artisan key:generate

# Change user to www and start php-fpm
USER www
EXPOSE 9000
CMD ["php-fpm"]
