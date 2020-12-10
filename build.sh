#!/usr/bin/env bash
base_dir=$(dirname "$0")

if [ $# != 1 ]; then
    echo "!> Missing group information." 
    echo "!> Usage: $0 <renew | server | g1 | g2 | g3>"
    exit
fi

if [ $# != 0 ]; then

  echo "$0 $1 running..."

  if [ "$1" == "renew" ]; then
    echo "rm -r $base_dir/tftp/"
          rm -r $base_dir/tftp/
    echo "rm -r $base_dir/web/"
          rm -r $base_dir/web/

    echo "rm -r $base_dir/mirai/release/"
          rm -r $base_dir/mirai/release/
    echo "rm -r $base_dir/mirai/debug/"
          rm -r $base_dir/mirai/debug/

  $base_dir/server.sh

  elif [ "$1" == "server" ]; then

    $base_dir/server.sh


  elif [ "$1" == "g1" ]; then

    $base_dir/server.sh
    $base_dir/iots.sh g1

  elif [ "$1" == "g2" ]; then

    $base_dir/iots.sh g2

  else

    $base_dir/iots.sh g3
    
  fi
fi

