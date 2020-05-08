#!/usr/bin/env bash
base_dir=$(dirname "$0")

echo "Starting mirai cnc and loader..."

echo "cd $base_dir"
      cd $base_dir

echo 'vagrant ssh mirai -c "sudo /vagrant/configs/start.sh"'
      vagrant ssh mirai -c "sudo /vagrant/configs/start.sh"
