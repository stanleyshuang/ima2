#!/usr/bin/env bash
base_dir=$(dirname "$0")
export ni="en0: Wi-Fi (AirPort)"
export ip_prx="192.168.0"
export tgt_psx="108"
export cnc_ip="$ip_prx.107"
export bot_ip="$ip_prx.$tgt_psx"

echo "ni=\"$ni\" ip_prx=\"$ip_prx\" cnc_ip=\"$cnc_ip\" bot_ip=\"$bot_ip\" tgt_psx=\"$tgt_psx\" vagrant "