#!/bin/bash
docker exec -ti $(docker ps | grep --color=never $1 | awk '{ print $1 }') /bin/bash
