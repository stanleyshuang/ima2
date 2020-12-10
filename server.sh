#!/usr/bin/env bash
base_dir=$(dirname "$0")

echo "Building mirai VM.."

echo "cd $base_dir"
      cd $base_dir
      
echo "ni=\"$ni\" dfgw=\"$dfgw\" ip_prx=\"$ip_prx\" cnc_ip=\"$cnc_ip\" tgt_bgn=\"$tgt_bgn\" tgt_end=\"$tgt_end\" vagrant up mirai"
      ni="$ni"   dfgw="$dfgw"   ip_prx="$ip_prx"   cnc_ip="$cnc_ip"   tgt_bgn="$tgt_bgn"   tgt_end="$tgt_end"   vagrant up mirai
