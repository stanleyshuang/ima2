#!/usr/bin/env bash
base_dir=$(dirname "$0")
export ni="en0: Wi-Fi (AirPort)"
export dfgw="172.20.10.1"
export cnc_ip="172.20.10.7"
export ip_prx="172.20.10"
export tgt_bgn="8"
export tgt_end="13"

echo "ni=\"$ni\" dfgw=\"$dfgw\" ip_prx=\"$ip_prx\" cnc_ip=\"$cnc_ip\" tgt_bgn=\"$tgt_bgn\" tgt_end=\"$tgt_end\" vagrant "