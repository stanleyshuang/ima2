#!/usr/bin/env bash
base_dir=$(dirname "$0")
echo "cd $base_dir"
      cd $base_dir

if [ $# != 1 ]; then
    echo "!> Missing group information." 
    echo "!> Usage: $0 <g1 | g2 | g3>"
    exit
fi

echo "Building IoT VMs (0 1 2 3)..."

if [ "$1" == "g1" ]; then
    
  echo "ni=\"$ni\" ip_prx=\"$ip_prx\" cnc_ip=\"$cnc_ip\" tgt_bgn=\"$tgt_bgn\" tgt_end=\"$tgt_end\" vagrant up target_0"
        ni="$ni"   ip_prx="$ip_prx"   cnc_ip="$cnc_ip"   tgt_bgn="$tgt_bgn"   tgt_end="$tgt_end"   vagrant up target_0

elif [ "$1" == "g2" ]; then
    
  echo "ni=\"$ni\" ip_prx=\"$ip_prx\" cnc_ip=\"$cnc_ip\" tgt_bgn=\"$tgt_bgn\" tgt_end=\"$tgt_end\" vagrant up target_1 target_2 target_3 target_4 target_5"
        ni="$ni"   ip_prx="$ip_prx"   cnc_ip="$cnc_ip"   tgt_bgn="$tgt_bgn"   tgt_end="$tgt_end"   vagrant up target_1 target_2 target_3 target_4 target_5

else
    
  echo "Under construction.."        

fi
