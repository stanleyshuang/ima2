#!/usr/bin/env bash
base_dir=$(dirname "$0")
export ni="6: USB 10/100/100 LA"
export cnc_ip="192.168.1.200"
export ip_prx="192.168.1"
export tgt_bgn="201"
export tgt_end="211"

echo "ni=\"$ni\" ip_prx=\"$ip_prx\" cnc_ip=\"$cnc_ip\" tgt_bgn=\"$tgt_bgn\" tgt_end=\"$tgt_end\" vagrant "