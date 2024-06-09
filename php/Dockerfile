FROM php:7.4.0-fpm

ENV LANG C.UTF-8

# install xdebug, pdo-mysql, unxip, supervisor
RUN apt-get update -qq && \
    apt-get install -y unzip supervisor && \
        pecl install xdebug-3.1.6 && \
        docker-php-ext-enable xdebug && \
        docker-php-ext-install pdo_mysql
COPY ./conf.d/20-xdebug.ini /usr/local/etc/php/conf.d/20-xdebug.ini
COPY ./supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir -p /var/log/supervisor

# install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === trim(file_get_contents('https://composer.github.io/installer.sig'))) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

# install sshd
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile


COPY authorized_keys /root/authorized_keys
RUN mkdir ~/.ssh && \
    mv ~/authorized_keys ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys

EXPOSE 22
CMD ["/usr/bin/supervisord"]
