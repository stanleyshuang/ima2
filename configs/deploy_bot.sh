#!/usr/bin/env bash
base_dir=$(dirname "$0")
echo "cd /vagrant/mirai/"
      cd /vagrant/mirai/
echo "./build.sh debug telnet"
      ./build.sh debug telnet
echo "scp ./debug/mirai.dbg "admin@$ip_prx.128:/home/admin""
      scp ./debug/mirai.dbg "admin@$ip_prx.128:/home/admin"
