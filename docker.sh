#!/bin/sh
function usage() {
    echo "usage: "
    echo "sh docker.sh [up|restart|down]"
    exit
}

if [[ $1 == "" ]]; then
   usage
   exit
fi

if [[ $1 == "start" ]]; then
    docker exec fpm pm2 start /home/myweb/app.json
    docker exec fpm pm2 log
fi

if [[ $1 == "restart" ]]; then
    docker exec fpm pm2 restart /home/myweb/app.json
    docker exec fpm pm2 log
fi

if [[ $1 == "stop" ]]; then
    docker exec fpm pm2 stop /home/myweb/app.json
fi

if [[ $1 == "log" ]]; then
    docker exec fpm pm2 log
fi


if [[ $1 == "status" ]]; then
    docker exec fpm pm2 status
fi