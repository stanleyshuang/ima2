#!/usr/bin/env bash
base_dir=$(dirname "$0")

echo "Building bot VM.."

echo "cd $base_dir"
      cd $base_dir

echo "vagrant destroy mirai target_0 target_1 target_2 target_3"
      vagrant destroy mirai target_0 target_1 target_2 target_3
