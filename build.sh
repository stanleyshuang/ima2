#!/usr/bin/env bash
base_dir=$(dirname "$0")

if [ $# != 1 ]; then
    echo "!> Missing group information." 
    echo "!> Usage: $0 <renew | g1 | g2 | g3>"
    exit
fi

if [ $# != 0 ]; then
  if [ "$1" == "renew" ]; then
    echo "rm -r $base_dir/tftp/"
          rm -r $base_dir/tftp/

    echo "rm -r $base_dir/mirai/release/"
          rm -r $base_dir/mirai/release/
    echo "rm -r $base_dir/mirai/debug/"
          rm -r $base_dir/mirai/debug/
  fi

  $base_dir/server.sh
  $base_dir/iots.sh g1

elif [ "$1" == "g1" ]; then

  $base_dir/server.sh
  $base_dir/iots.sh g1

elif [ "$1" == "g2" ]; then

  $base_dir/iots.sh g2

else

  $base_dir/iots.sh g3
fi

