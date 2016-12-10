#!/bin/bash
set -x
rc=$(cf ic info | grep "Not logged" --color=never)

if [ $? -eq 1 ]
   then
      echo "Already authenticated."
      cf target
      source ./set-docker-2-bluemix.sh
      exit 0
fi

if [[ $PWD != */tools  ]] 
    then 
       echo "must be in the tools directory" 
       exit 1 
fi

if [ "$#" -ne 4 ]
  then
    echo "You only gave me $# parms."
    echo "Note:  this only supports Linux, the sed command fails for MAC."  #to-do support mac
    echo "usage:  ics_auth.sh [api] [username] [password] [space]"
    echo "example:  ics_auth.sh https://api.ng.bluemix.net username@email.com passw0rd dev"
    exit 1
fi
CF_API=$1
CF_USERNAME=$2
CF_PASSWORD=$3
SPACE=$4

cf api $1
cf login -u $CF_USERNAME -p $CF_PASSWORD -o adtech -s $SPACE
cf ic login | grep "export DOCKER" > /tmp/.env

# REMOVE TABS
sed -i 's/^[ \t]*//' /tmp/.env
. /tmp/.env
source /tmp/.env

ndh=$(cat /tmp/.env | grep "export DOCKER_HOST=" | sed 's/export DOCKER_HOST=//')
new_docker_host=$(echo $ndh |  sed -e 's/^[ \t]*//')
sed -i "s|export DOCKER_HOST=.*|export DOCKER_HOST=$new_docker_host|g"  set-docker-2-bluemix.sh

ndh=$(cat /tmp/.env | grep "export DOCKER_CERT_PATH=" | sed 's/export DOCKER_CERT_PATH=//')
new_docker_host=$(echo $ndh |  sed -e 's/^[ \t]*//')
sed -i "s|export DOCKER_CERT_PATH=.*|export DOCKER_CERT_PATH=$new_docker_host|g"  set-docker-2-bluemix.sh

ndh=$(cat /tmp/.env | grep "export DOCKER_TLS_VERIFY=" | sed 's/export DOCKER_TLS_VERIFY=//')
new_docker_host=$(echo $ndh |  sed -e 's/^[ \t]*//')
sed -i "s|export DOCKER_TLS_VERIFY=.*|export DOCKER_TLS_VERIFY=$new_docker_host|g"  set-docker-2-bluemix.sh

