#!/usr/bin/env bash
base_dir=$(dirname "$0")
if [ $# != 1 ]; then
    echo "!> Missing build type." 
    echo "!> Usage: $0 <server | iots | all>"
    exit
fi

if [ "$1" == "server" ]; then

    DEVICES="mirai"

elif [ "$1" == "iots" ]; then

    DEVICES="target_0 target_1 target_2 target_3"

elif [ "$1" == "all" ]; then

    DEVICES="mirai target_0 target_1 target_2 target_3"

else
    echo "Unknown parameter $1: $0"
fi

echo "Destroy VM.."

echo "cd $base_dir"
      cd $base_dir

echo "vagrant destroy $DEVICES -f"
      vagrant destroy $DEVICES -f
