#!/usr/bin/env bash
base_dir=$(dirname "$0")
echo "cd $base_dir"
      cd $base_dir

telnet_funtion(){
  target=$1
  dfgw=$2
  (
  echo open "$target"
  sleep 2
  echo "admin"
  sleep 2
  echo "admin"
  sleep 2
  echo "sudo -i"
  sleep 2
  echo "ifconfig eth0 down"
  sleep 2
  echo "route add default gw $dfgw"
  sleep 2
  echo "exit"
  ) | telnet
}

if [ $# != 1 ]; then
  echo "!> Missing group information." 
  echo "!> Usage: $0 <g1 | g2 | g3>"
  exit
fi

echo "Building IoT VMs (0 1 2 3)..."

if [ "$1" == "g1" ]; then
    
  echo "ni=\"$ni\" dfgw=\"$dfgw\" ip_prx=\"$ip_prx\" cnc_ip=\"$cnc_ip\" tgt_bgn=\"$tgt_bgn\" tgt_end=\"$tgt_end\" vagrant up target_0"
        ni="$ni"   dfgw="$dfgw"   ip_prx="$ip_prx"   cnc_ip="$cnc_ip"   tgt_bgn="$tgt_bgn"   tgt_end="$tgt_end"   vagrant up target_0

  echo "telnet_funtion  $ip_prx.$tgt_bgn   $dfgw"
        telnet_funtion "$ip_prx.$tgt_bgn" "$dfgw"

elif [ "$1" == "g2" ]; then
    
  echo "ni=\"$ni\" dfgw=\"$dfgw\" ip_prx=\"$ip_prx\" cnc_ip=\"$cnc_ip\" tgt_bgn=\"$tgt_bgn\" tgt_end=\"$tgt_end\" vagrant up target_1 target_2 target_3 target_4 target_5"
        ni="$ni"   dfgw="$dfgw"   ip_prx="$ip_prx"   cnc_ip="$cnc_ip"   tgt_bgn="$tgt_bgn"   tgt_end="$tgt_end"   vagrant up target_1 target_2 target_3 target_4 target_5

  for target in $(seq 1 5)
  do
    sum=$(( $tgt_bgn + $target ))
    echo "telnet_funtion  $ip_prx.$sum   $dfgw"
          telnet_funtion "$ip_prx.$sum" "$dfgw"
  done

else
    
  echo "Under construction.."        

fi
