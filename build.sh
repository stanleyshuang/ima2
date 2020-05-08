#!/usr/bin/env bash
base_dir=$(dirname "$0")

echo "Building mirai VM..."

echo "cd $base_dir"
      cd $base_dir
      
echo "ni=\"$ni\" cnc_ip=\"$cnc_ip\" ip_prx=\"$ip_prx\" vagrant up mirai"
      ni="$ni"   cnc_ip="$cnc_ip"   ip_prx="$ip_prx"   vagrant up mirai
