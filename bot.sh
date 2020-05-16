#!/usr/bin/env bash
base_dir=$(dirname "$0")

echo "Building bot VM.."

echo "cd $base_dir"
      cd $base_dir

echo "ni=\"$ni\" ip_prx=\"$ip_prx\" cnc_ip=\"$cnc_ip\" tgt_psx=\"$tgt_psx\" vagrant up target_0"
      ni="$ni"   ip_prx="$ip_prx"   cnc_ip="$cnc_ip"   tgt_psx="$tgt_psx"   vagrant up target_0
