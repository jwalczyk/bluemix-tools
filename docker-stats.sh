#!/bin/bash

docker stats $(docker ps | awk '{if(NR>1) print $NF}')
