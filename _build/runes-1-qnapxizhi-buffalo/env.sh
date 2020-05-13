#!/usr/bin/env bash
base_dir=$(dirname "$0")
export ni="en6: USB 10/100/1000 LAN"
export ip_prx="172.17.28"
export tgt_psx="41"
export cnc_ip="$ip_prx.52"
export bot_ip="$ip_prx.$tgt_psx"

echo "ni=\"$ni\" ip_prx=\"$ip_prx\" cnc_ip=\"$cnc_ip\" bot_ip=\"$bot_ip\" tgt_psx=\"$tgt_psx\" vagrant "