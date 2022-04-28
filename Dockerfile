FROM php:8.0-apache

USER 0
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    vim \
    curl \
    libldap2-dev \
    libfreetype6-dev \
    libjpeg-dev \
    libonig-dev \
    zlib1g-dev \
    libc-client-dev \
    libkrb5-dev \
    libpng-dev \
    libpq-dev \
    libzip-dev \
    libtidy-dev \
    libsodium-dev \
    && apt-get -y autoclean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*
  
RUN ln -fs /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/

RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr \ 
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install -j5 \
    exif \
    gd \
    imap \
    ldap \
    mbstring \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    sodium \
    tidy \
    zip

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# releases: https://github.com/LimeSurvey/LimeSurvey/tags
ARG version=5.3.10+220419

RUN curl -sSL "https://github.com/LimeSurvey/LimeSurvey/archive/${version}.tar.gz" --output /tmp/limesurvey.tar.gz \
    && tar xzvf "/tmp/limesurvey.tar.gz" --strip-components=1 -C /var/www/html \
    && rm -f "/tmp/limesurvey.tar.gz" \
    && mkdir -p /var/www/html/tmp/runtime/cache \ 
    && mkdir -p /var/www/html/assets \ 
    && chown -R "1001:1001" /var/www/html /etc/apache2 \
    && chmod -R 777 /var/www/html/

COPY security.php /var/www/html/application/config/security.php
COPY config.php /var/www/html/application/config/config.php
COPY entrypoint.sh /var/www/html/application/config/entrypoint.sh
COPY ports.conf /etc/apache2/ports.conf

USER 1001

WORKDIR /var/www/html

EXPOSE 8080 

ENTRYPOINT ["/var/www/html/application/config/entrypoint.sh"]
CMD ["apache2-foreground"] 
