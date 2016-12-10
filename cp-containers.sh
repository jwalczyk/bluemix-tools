#!/bin/bash
echo "Copy all docker images to another target machine.  Then on the target, simply run 'docker-compose up -d"

containers=$(docker images | awk '{print $1}' | grep -v REPOSITORY)

for i in $containers; do
      docker save $containers | bzip2 | pv | ssh ibmadmin@$1 'bunzip2 | docker load'
done


