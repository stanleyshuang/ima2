#!/usr/bin/env bash
base_dir=$(dirname "$0")
export ni="en0: Wi-Fi (Wireless)"
export ip_prx="172.20.10"
export cnc_ip="$ip_prx.3"
export bot_ip="$ip_prx.4"
export tgt_psx="5"

echo "ni=\"$ni\" ip_prx=\"$ip_prx\" cnc_ip=\"$cnc_ip\" bot_ip=\"$bot_ip\" tgt_psx=\"$tgt_psx\" vagrant "