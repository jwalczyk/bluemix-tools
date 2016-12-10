#!/bin/bash
docker rm $(docker ps -a | grep "Exited" | awk '{print($1)}')
docker rm `docker ps -a  | grep Exit | awk '{ print $1 }'`
for i in $(docker ps -a |awk '!/^C/ {print $1}'); do docker rm -f $i; done
docker rmi -f $(docker images | grep "<none>" | awk '{print($3)}')
