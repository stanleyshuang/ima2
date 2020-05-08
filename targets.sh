#!/usr/bin/env bash
base_dir=$(dirname "$0")

echo "Building target VMs (1, 2, 3)..."

echo "cd $base_dir"
      cd $base_dir

echo "vagrant up target_1 target_2 target_3"
      vagrant up target_1 target_2 target_3
