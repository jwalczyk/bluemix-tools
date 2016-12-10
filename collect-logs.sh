#!/bin/bash

#  When we do docker logs container-id with ICS,  the result are hacked up binary-like files that you can't grep
#  This script captures all logs for all containers and writes them to an output we can easily grep on 

#  instruct text processing tools to operate on bytes by changing the locale. Specifically, select the locale, which basically means means nothing fancy
export LC_CTYPE=C

LIST=$(docker ps -a | awk '{print $1}')
array_names=($LIST)

for name in "${array_names[@]}"
do
     if [ "$name" != "CONTAINER" ]; then
        echo "writing to ...$name.log"
	rc=$(docker logs $name > logs/$name.log)

        #  Remove non-printable ASCII characters from a file with this Unix command
        tr -cd '\11\12\15\40-\176' < logs/$name.log > logs/$name-clean.log

        rm -f logs/$name.log
     fi
done
