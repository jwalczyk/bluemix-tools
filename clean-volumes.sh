#!/bin/bash

docker volume ls | grep local | awk {'print $2'} | xargs docker volume rm
