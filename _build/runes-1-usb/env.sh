#!/usr/bin/env bash
base_dir=$(dirname "$0")
export ni="en6: USB 10/100/1000 LAN"
export ip_prx="192.168.11"
export cnc_ip="$ip_prx.3"

echo "ni=\"$ni\" cnc_ip=\"$cnc_ip\" ip_prx=\"$ip_prx\""