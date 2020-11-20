#!/bin/bash

if [ $# != 1 ]; then
    echo "!> Missing build type." 
    echo "!> Usage: $0 <debug | release>"
    exit
fi

if [ "$1" == "release" ]; then

  gcc -w -static -O3 -lpthread -pthread src/*.c -o loader

elif [ "$1" == "debug" ]; then

  gcc -lefence -g -DDEBUG -static -lpthread -pthread -O3 src/*.c -o loader.dbg

else
    echo "Unknown parameter $1: $0"
fi
