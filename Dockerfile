FROM php:8.3.3-cli

COPY --from=composer:2 /usr/bin/composer /usr/local/bin

RUN apt update && apt install -y --no-install-recommends unzip libicu-dev

RUN docker-php-ext-install -j$(nproc) bcmath intl

WORKDIR /app-appname
COPY . /app-appname

RUN composer install
RUN cd second && composer install

RUN ./vendor/bin/psalm
