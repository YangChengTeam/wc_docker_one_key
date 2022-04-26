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

RUN chmod -R 777 /home/myweb/yf-local/runtime

RUN apt-get install -y nodejs npm wget
RUN apt-get install g++  && \
    wget --no-check-certificate --user-agent=Mozilla -O apache-pulsar-client-dev.deb "https://archive.apache.org/dist/pulsar/pulsar-2.9.1/DEB/apache-pulsar-client-dev.deb" && \
    wget --no-check-certificate --user-agent=Mozilla -O apache-pulsar-client.deb "https://archive.apache.org/dist/pulsar/pulsar-2.9.1/DEB/apache-pulsar-client.deb" && \
    dpkg --force-architecture -i apache-pulsar-client*.deb

WORKDIR  /home/myweb/yf-local
RUN npm install pulsar-client --unsafe-perm=true --allow- && \
    npm install -g pm2 --registry=https://registry.npm.taobao.org


