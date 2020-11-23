#!/usr/bin/env bash
base_dir=$(dirname "$0")
if [ $# != 1 ]; then
    echo "!> Missing build type." 
    echo "!> Usage: $0 <server | g1 | g2 | g3 | all>"
    exit
fi

if [ "$1" == "server" ]; then

    DEVICES="mirai"

elif [ "$1" == "g1" ]; then

    DEVICES="target_0 target_1 target_2 target_3"

elif [ "$1" == "g2" ]; then

    DEVICES="target_4 target_5 target_6 target_7"
    

elif [ "$1" == "all" ]; then

    DEVICES="mirai target_0 target_1 target_2 target_3 target_4 target_5 target_6 target_7 target_8 target_9 target_10"

else
    DEVICES="target_8 target_9 target_10"
fi

echo "Destroy VM.."

echo "vagrant destroy $DEVICES -f"
      vagrant destroy $DEVICES -f
