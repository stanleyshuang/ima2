#!/usr/bin/env bash
base_dir=$(dirname "$0")

echo "Starting mirai cnc and loader..."

echo "cd $base_dir"
      cd $base_dir

echo 'ni=\"$ni\" cnc_ip=\"$cnc_ip\" ip_prx=\"$ip_prx\" vagrant ssh mirai -c "sudo /vagrant/configs/start.sh"'
      ni="$ni"   cnc_ip="$cnc_ip"   ip_prx="$ip_prx"   vagrant ssh mirai -c "sudo /vagrant/configs/start.sh"
