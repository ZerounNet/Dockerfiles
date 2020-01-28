FROM ubuntu:18.04

ENV TZ=Asia/Shanghai \
    LANG=C.UTF-8 \
    SHELL=/bin/bash \
    TERM=xterm-256color

RUN export DEBIAN_FRONTEND=noninteractive \
    &&  sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
    && sed -i 's/security.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list  \
    && apt-get update  && apt-get install wget apt-utils tzdata locales vim -y \
    && apt-get install -y php-cli php-fpm php-redis php-memcache php-memcached php-mbstring php-json php-amqp php-zip php-gd php-bcmath php-mysql php-xml php-bz2  php-curl php-intl php-xdebug composer \
    && apt-get install -y php-dev libmcrypt-dev php-pear \
    && pecl channel-update pecl.php.net \
    && echo "\n" | pecl install mcrypt \
    && echo 'extension=mcrypt.so' > /etc/php/7.2/mods-available/mcrypt.ini \
    && ln -s /etc/php/7.2/mods-available/mcrypt.ini /etc/php/7.2/cli/conf.d/20-mcrypt.ini \
    && ln -s /etc/php/7.2/mods-available/mcrypt.ini /etc/php/7.2/fpm/conf.d/20-mcrypt.ini \
    && echo "y\ny\ny\ny" | pecl install swoole \
    && echo 'extension=swoole.so' > /etc/php/7.2/mods-available/swoole.ini \
    && ln -s /etc/php/7.2/mods-available/swoole.ini /etc/php/7.2/cli/conf.d/20-swoole.ini \
    && locale-gen zh_CN.UTF-8 \
    && apt-get clean -y && rm -rf /var/cache/apt/* && rm /var/lib/apt/lists/* -rf && rm /tmp/* -rf