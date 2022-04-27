#!/bin/sh
function usage() {
    echo "usage: "
    echo "sh app.sh [start|restart|stop|log|status|config|debug]"
    exit
}

if [[ $1 == "" ]]; then
   usage
   exit
fi

if [[ $1 == "config" ]]; then 
   docker exec fpm chmod -R 777 /home/myweb/yf-local/runtime
   docker exec fpm npm install --prefix /home/myweb/pulsar pulsar-client
fi

if [[ $1 == "start" ]]; then 
    docker exec fpm pm2 start /home/myweb/app.json
    docker exec fpm pm2 log
fi

if [[ $1 == "restart" ]]; then
    docker exec fpm pm2 restart all
    docker exec fpm pm2 log
fi

if [[ $1 == "stop" ]]; then
    docker exec fpm pm2 stop all
fi

if [[ $1 == "log" ]]; then
    docker exec fpm pm2 log
fi


if [[ $1 == "status" ]]; then
    docker exec fpm pm2 status
fi

if [[ $1 == "debug" ]]; then
    docker exec -it  fpm bash
fi