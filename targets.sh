#!/usr/bin/env bash
base_dir=$(dirname "$0")

echo "Building target VMs (1, 2, 3)..."

echo "cd $base_dir"
      cd $base_dir

echo "ni=\"$ni\" cnc_ip=\"$cnc_ip\" ip_prx=\"$ip_prx\" vagrant up target_1 target_2 target_3"
      ni="$ni"   cnc_ip="$cnc_ip"   ip_prx="$ip_prx"   vagrant up target_1 target_2 target_3
