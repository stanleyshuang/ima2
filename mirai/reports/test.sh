target_0_ip=$ip_prx'.'$tgt_bgn
target_0_hex=$(printf '%02X' ${target_0_ip//./} ; echo)
echo -e '\x00\xc0\xa8\x00\x6d\x17\x00\x05admin\x05pass' | nc 127.0.0.1 48101   # 6d00a8c0 --> 192.168.0.109
