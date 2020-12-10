#!/usr/bin/env bash
base_dir=$(dirname "$0")
export ni="en0: 乙太網路"
export dfgw="192.168.1.1"
export cnc_ip="192.168.1.199"
export ip_prx="192.168.1"
export tgt_bgn="200"
export tgt_end="205"

echo "ni=\"$ni\" dfgw=\"$dfgw\" ip_prx=\"$ip_prx\" cnc_ip=\"$cnc_ip\" tgt_bgn=\"$tgt_bgn\" tgt_end=\"$tgt_end\" vagrant "