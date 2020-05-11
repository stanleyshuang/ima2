#!/usr/bin/env bash
base_dir=$(dirname "$0")

echo "Building target VMs (1)..."

echo "cd $base_dir"
      cd $base_dir

echo "ni=\"$ni\" ip_prx=\"$ip_prx\" cnc_ip=\"$cnc_ip\" bot_ip=\"$bot_ip\" tgt_psx=\"$tgt_psx\" vagrant up target_1"
      ni="$ni"   ip_prx="$ip_prx"   cnc_ip="$cnc_ip"   bot_ip="$bot_ip"   tgt_psx="$tgt_psx"   vagrant up target_1
