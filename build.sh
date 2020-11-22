#!/usr/bin/env bash
base_dir=$(dirname "$0")

if [ $# >= 1 ]; then
  if [ "$1" == "renew" ]; then
    echo "rm -r $base_dir/tftp/"
          rm -r $base_dir/tftp/

    echo "rm -r $base_dir/mirai/release/"
          rm -r $base_dir/mirai/release/
    echo "rm -r $base_dir/mirai/debug/"
          rm -r $base_dir/mirai/debug/
  fi
fi

$base_dir/server.sh
$base_dir/iots.sh
