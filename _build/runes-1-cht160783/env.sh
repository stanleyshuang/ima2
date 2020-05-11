#!/usr/bin/env bash
base_dir=$(dirname "$0")
export ni="en0: Wi-Fi (AirPort)"
export ip_prx="192.168.0"
export cnc_ip="$ip_prx.107"

echo "ni=\"$ni\" cnc_ip=\"$cnc_ip\" ip_prx=\"$ip_prx\""