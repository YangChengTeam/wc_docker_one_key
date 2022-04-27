FROM php:7-fpm

RUN  sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
     sed -i s@/deb.debian.org/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
	 apt-get clean
RUN apt-get update && apt-get install -y \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libpng-dev 
RUN pecl install  redis
RUN docker-php-ext-install mysqli 
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install pdo pdo_mysql
RUN docker-php-ext-install sockets
RUN docker-php-ext-enable redis pcntl mysqli pdo pdo_mysql sockets



COPY apache-pulsar-client-dev.deb /opt/apache-pulsar-client-dev.deb
COPY apache-pulsar-client.deb /opt/apache-pulsar-client.deb
RUN dpkg -i  /opt/apache-pulsar-client*.deb

RUN apt-get install -y wget
RUN wget -qO- https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs
RUN apt-get install g++
    
WORKDIR /home/myweb/pulsar
RUN npm install -g pm2 --registry=https://registry.npm.taobao.org