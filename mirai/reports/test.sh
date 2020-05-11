target_1_ip=$ip_prx'.129'
target_1_hex=$(printf '%02X' ${target_1_ip//./} ; echo)
echo -e '\x00\xc0\xa8\x00\x81\x17\x00\x05admin\x05pass' | nc 127.0.0.1 48101
echo -e '\x00\xc0\xa8\x00\x83\x17\x00\x05admin\x05pass' | nc 127.0.0.1 48101

# 6b00a8c0 --> 192.168.0.107
